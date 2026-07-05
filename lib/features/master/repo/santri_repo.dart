import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pesantren_management/core/error.dart';
import 'package:pesantren_management/core/result.dart';
import 'package:pesantren_management/features/master/models/santri.dart';

class SantriRepo {
  final SupabaseClient _client;

  SantriRepo(this._client);

  SupabaseClient get client => _client;

  /// List santri with optional filters
  /// Pattern from Mizan: select() first, then chain filters via dynamic query
  Future<Result<List<Santri>, AppError>> list({
    String? search,
    String? status,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      dynamic query = _client.from('mst_santri').select();

      query = query.eq('is_deleted', false);

      if (search != null && search.isNotEmpty) {
        query = query.or('nis.ilike.%$search%,nama.ilike.%$search%');
      }
      if (status != null && status.isNotEmpty) {
        query = query.eq('status', status);
      }

      final res = await query
          .order('nama', ascending: true)
          .range(offset, offset + limit - 1);

      return Ok((res as List).map((e) => Santri.fromJson(e)).toList());
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  /// Get single santri by ID
  Future<Result<Santri, AppError>> get(String id) async {
    try {
      final res = await _client
          .from('mst_santri')
          .select()
          .eq('id', id)
          .single();
      return Ok(Santri.fromJson(res));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  /// Create new santri
  Future<Result<Santri, AppError>> create({
    required String nis,
    required String nama,
    String? tanggalLahir,
    String? jenisKelamin,
    String? alamat,
    String? telepon,
    String status = 'aktif',
  }) async {
    try {
      final data = {
        'nis': nis,
        'nama': nama,
        'tanggal_lahir': tanggalLahir,
        'jenis_kelamin': jenisKelamin,
        'alamat': alamat,
        'telepon': telepon,
        'status': status,
      };
      final res = await _client.from('mst_santri').insert(data).select().single();
      return Ok(Santri.fromJson(res));
    } on PostgrestException catch (e) {
      if (e.code == '23505') { // unique violation
        return const Err(ValidationError('NIS sudah digunakan'));
      }
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  /// Update santri (master data editable)
  Future<Result<Santri, AppError>> update(
    String id, {
    String? nis,
    String? nama,
    String? tanggalLahir,
    String? jenisKelamin,
    String? alamat,
    String? telepon,
    String? status,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (nis != null) data['nis'] = nis;
      if (nama != null) data['nama'] = nama;
      if (tanggalLahir != null) data['tanggal_lahir'] = tanggalLahir;
      if (jenisKelamin != null) data['jenis_kelamin'] = jenisKelamin;
      if (alamat != null) data['alamat'] = alamat;
      if (telepon != null) data['telepon'] = telepon;
      if (status != null) data['status'] = status;
      data['updated_at'] = DateTime.now().toIso8601String();

      final res = await _client
          .from('mst_santri')
          .update(data)
          .eq('id', id)
          .select()
          .single();
      return Ok(Santri.fromJson(res));
    } on PostgrestException catch (e) {
      if (e.code == '23505') {
        return const Err(ValidationError('NIS sudah digunakan'));
      }
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  /// Soft delete santri
  Future<Result<void, AppError>> delete(String id) async {
    try {
      await _client
          .from('mst_santri')
          .update({'is_deleted': true, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', id);
      return const Ok(null);
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  /// Restore soft-deleted santri
  Future<Result<void, AppError>> restore(String id) async {
    try {
      await _client
          .from('mst_santri')
          .update({'is_deleted': false, 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', id);
      return const Ok(null);
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }
}