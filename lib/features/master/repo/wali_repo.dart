import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pesantren_management/core/error.dart';
import 'package:pesantren_management/core/result.dart';
import 'package:pesantren_management/features/master/models/wali.dart';

class WaliRepo {
  final SupabaseClient _client;

  WaliRepo(this._client);

  Future<Result<List<Wali>, AppError>> list({int limit = 50, int offset = 0}) async {
    try {
      final data = await _client
          .from('pm_wali')
          .select()
          .neq('id', '00000000-0000-0000-0000-000000000000')
          .order('created_at', ascending: false)
          .limit(limit)
          .range(offset, offset + limit - 1);
      final items = (data as List).map((e) => Wali.fromJson(e)).toList();
      return Ok(items);
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<List<Wali>, AppError>> search(String query) async {
    try {
      final data = await _client
          .from('pm_wali')
          .select()
          .neq('id', '00000000-0000-0000-0000-000000000000')
          .ilike('nama', '%$query%')
          .limit(20);
      final items = (data as List).map((e) => Wali.fromJson(e)).toList();
      return Ok(items);
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<Wali, AppError>> get(String id) async {
    try {
      final data = await _client.from('pm_wali').select().eq('id', id).single();
      return Ok(Wali.fromJson(data));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<Wali, AppError>> create({required String nama, String? noTelp, String? alamat}) async {
    try {
      final data = await _client.from('pm_wali').insert({
        'nama': nama,
        if (noTelp != null) 'no_telp': noTelp,
        if (alamat != null) 'alamat': alamat,
      }).select().single();
      return Ok(Wali.fromJson(data));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<Wali, AppError>> update(String id, {String? nama, String? noTelp, String? alamat}) async {
    try {
      final data = await _client.from('pm_wali').update({
        if (nama != null) 'nama': nama,
        if (noTelp != null) 'no_telp': noTelp,
        if (alamat != null) 'alamat': alamat,
      }).eq('id', id).select().single();
      return Ok(Wali.fromJson(data));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<void, AppError>> delete(String id) async {
    try {
      await _client.from('pm_wali').delete().eq('id', id);
      return const Ok(null);
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }
}