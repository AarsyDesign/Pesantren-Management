import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pesantren_management/core/error.dart';
import 'package:pesantren_management/core/result.dart';
import 'package:pesantren_management/features/master/models/santri_kelas.dart';

class SantriKelasRepo {
  final SupabaseClient _client;

  SantriKelasRepo(this._client);

  SupabaseClient get client => _client;

  Future<Result<List<SantriKelas>, AppError>> list({
    String? tahunAjaranId,
    String? kelasId,
    String? santriId,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      dynamic query = _client.from('trx_santri_kelas').select();
      if (tahunAjaranId != null) {
        query = query.eq('tahun_ajaran_id', tahunAjaranId);
      }
      if (kelasId != null) {
        query = query.eq('kelas_id', kelasId);
      }
      if (santriId != null) {
        query = query.eq('santri_id', santriId);
      }
      query = query.order('tanggal_masuk', ascending: false).range(offset, offset + limit - 1);
      final res = await query;
      return Ok((res as List).map((e) => SantriKelas.fromJson(e)).toList());
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<SantriKelas, AppError>> get(String id) async {
    try {
      final res = await _client.from('trx_santri_kelas').select().eq('id', id).single();
      return Ok(SantriKelas.fromJson(res));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<SantriKelas, AppError>> enroll({
    required String tahunAjaranId,
    required String santriId,
    required String kelasId,
    DateTime? tanggalMasuk,
    String status = 'aktif',
  }) async {
    try {
      final data = {
        'tahun_ajaran_id': tahunAjaranId,
        'santri_id': santriId,
        'kelas_id': kelasId,
        'tanggal_masuk': (tanggalMasuk ?? DateTime.now()).toIso8601String().split('T').first,
        'status': status,
      };
      final res = await _client.from('trx_santri_kelas').insert(data).select().single();
      return Ok(SantriKelas.fromJson(res));
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        return const Err(ValidationError('Santri sudah terdaftar di kelas ini'));
      }
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<SantriKelas, AppError>> transfer(
    String id, {
    required String newKelasId,
    DateTime? tanggalKeluar,
  }) async {
    try {
      final data = <String, dynamic>{
        'kelas_id': newKelasId,
        'updated_at': DateTime.now().toIso8601String(),
      };
      if (tanggalKeluar != null) {
        data['tanggal_keluar'] = tanggalKeluar.toIso8601String().split('T').first;
      }

      final res = await _client
          .from('trx_santri_kelas')
          .update(data)
          .eq('id', id)
          .select()
          .single();
      return Ok(SantriKelas.fromJson(res));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<SantriKelas, AppError>> drop(
    String id, {
    DateTime? tanggalKeluar,
  }) async {
    try {
      final data = <String, dynamic>{
        'status': 'keluar',
        'tanggal_keluar': (tanggalKeluar ?? DateTime.now()).toIso8601String().split('T').first,
        'updated_at': DateTime.now().toIso8601String(),
      };

      final res = await _client
          .from('trx_santri_kelas')
          .update(data)
          .eq('id', id)
          .select()
          .single();
      return Ok(SantriKelas.fromJson(res));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<void, AppError>> delete(String id) async {
    try {
      await _client.from('trx_santri_kelas').delete().eq('id', id);
      return const Ok(null);
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }
}