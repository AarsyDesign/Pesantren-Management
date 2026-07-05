import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pesantren_management/core/error.dart';
import 'package:pesantren_management/core/result.dart';
import 'package:pesantren_management/features/master/models/tahun_ajaran.dart';

class TahunAjaranRepo {
  final SupabaseClient _client;

  TahunAjaranRepo(this._client);

  SupabaseClient get client => _client;

  Future<Result<List<TahunAjaran>, AppError>> list({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      dynamic query = _client.from('mst_tahun_ajaran').select();
      query = query.order('mulai', ascending: false).range(offset, offset + limit - 1);
      final res = await query;
      return Ok((res as List).map((e) => TahunAjaran.fromJson(e)).toList());
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<TahunAjaran, AppError>> get(String id) async {
    try {
      final res = await _client.from('mst_tahun_ajaran').select().eq('id', id).single();
      return Ok(TahunAjaran.fromJson(res));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<TahunAjaran, AppError>> create({
    required String nama,
    required DateTime mulai,
    required DateTime selesai,
    bool aktif = false,
  }) async {
    try {
      final data = {
        'nama': nama,
        'mulai': mulai.toIso8601String().split('T').first,
        'selesai': selesai.toIso8601String().split('T').first,
        'aktif': aktif,
      };
      final res = await _client.from('mst_tahun_ajaran').insert(data).select().single();
      return Ok(TahunAjaran.fromJson(res));
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        return const Err(ValidationError('Nama tahun ajaran sudah digunakan'));
      }
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<TahunAjaran, AppError>> update(
    String id, {
    String? nama,
    DateTime? mulai,
    DateTime? selesai,
    bool? aktif,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (nama != null) data['nama'] = nama;
      if (mulai != null) data['mulai'] = mulai.toIso8601String().split('T').first;
      if (selesai != null) data['selesai'] = selesai.toIso8601String().split('T').first;
      if (aktif != null) data['aktif'] = aktif;
      data['updated_at'] = DateTime.now().toIso8601String();

      final res = await _client
          .from('mst_tahun_ajaran')
          .update(data)
          .eq('id', id)
          .select()
          .single();
      return Ok(TahunAjaran.fromJson(res));
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        return const Err(ValidationError('Nama tahun ajaran sudah digunakan'));
      }
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<void, AppError>> delete(String id) async {
    try {
      await _client.from('mst_tahun_ajaran').delete().eq('id', id);
      return const Ok(null);
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<TahunAjaran, AppError>> setActive(String id) async {
    try {
      await _client.from('mst_tahun_ajaran').update({'aktif': false});
      final res = await _client
          .from('mst_tahun_ajaran')
          .update({'aktif': true, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', id)
          .select()
          .single();
      return Ok(TahunAjaran.fromJson(res));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }
}