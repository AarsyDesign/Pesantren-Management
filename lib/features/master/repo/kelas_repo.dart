import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pesantren_management/core/error.dart';
import 'package:pesantren_management/core/result.dart';
import 'package:pesantren_management/features/master/models/kelas.dart';

class KelasRepo {
  final SupabaseClient _client;

  KelasRepo(this._client);

  SupabaseClient get client => _client;

  Future<Result<List<Kelas>, AppError>> list({
    String? tahunAjaranId,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      dynamic query = _client.from('mst_kelas').select();
      if (tahunAjaranId != null) {
        query = query.eq('tahun_ajaran_id', tahunAjaranId);
      }
      query = query.order('nama', ascending: true).range(offset, offset + limit - 1);
      final res = await query;
      return Ok((res as List).map((e) => Kelas.fromJson(e)).toList());
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<Kelas, AppError>> get(String id) async {
    try {
      final res = await _client.from('mst_kelas').select().eq('id', id).single();
      return Ok(Kelas.fromJson(res));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<Kelas, AppError>> create({
    required String tahunAjaranId,
    required String nama,
    String? waliId,
    int kapasitas = 30,
  }) async {
    try {
      final data = {
        'tahun_ajaran_id': tahunAjaranId,
        'nama': nama,
        'wali_id': waliId,
        'kapasitas': kapasitas,
      };
      final res = await _client.from('mst_kelas').insert(data).select().single();
      return Ok(Kelas.fromJson(res));
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        return const Err(ValidationError('Nama kelas sudah digunakan di tahun ajaran ini'));
      }
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<Kelas, AppError>> update(
    String id, {
    String? nama,
    String? waliId,
    int? kapasitas,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (nama != null) data['nama'] = nama;
      if (waliId != null) data['wali_id'] = waliId;
      if (kapasitas != null) data['kapasitas'] = kapasitas;
      data['updated_at'] = DateTime.now().toIso8601String();

      final res = await _client
          .from('mst_kelas')
          .update(data)
          .eq('id', id)
          .select()
          .single();
      return Ok(Kelas.fromJson(res));
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        return const Err(ValidationError('Nama kelas sudah digunakan di tahun ajaran ini'));
      }
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<void, AppError>> delete(String id) async {
    try {
      await _client.from('mst_kelas').delete().eq('id', id);
      return const Ok(null);
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }
}