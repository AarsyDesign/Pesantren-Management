import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pesantren_management/core/error.dart';
import 'package:pesantren_management/core/result.dart';
import 'package:pesantren_management/features/master/models/wali_santri.dart';

class WaliSantriRepo {
  final SupabaseClient _client;

  WaliSantriRepo(this._client);

  Future<Result<List<WaliSantri>, AppError>> list({
    String? waliId,
    String? santriId,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      var query = _client.from('pm_wali_santri').select().neq('id', '00000000-0000-0000-0000-000000000000');
      if (waliId != null) query = query.eq('wali_id', waliId);
      if (santriId != null) query = query.eq('santri_id', santriId);
      final data = await query.order('created_at', ascending: false).limit(limit).range(offset, offset + limit - 1);
      final items = (data as List).map((e) => WaliSantri.fromJson(e)).toList();
      return Ok(items);
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<WaliSantri, AppError>> get(String id) async {
    try {
      final data = await _client.from('pm_wali_santri').select().eq('id', id).single();
      return Ok(WaliSantri.fromJson(data));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<WaliSantri, AppError>> link({
    required String waliId,
    required String santriId,
    required String hubungan,
  }) async {
    try {
      final data = await _client.from('pm_wali_santri').insert({
        'wali_id': waliId,
        'santri_id': santriId,
        'hubungan': hubungan,
      }).select().single();
      return Ok(WaliSantri.fromJson(data));
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<Result<void, AppError>> unlink(String id) async {
    try {
      await _client.from('pm_wali_santri').delete().eq('id', id);
      return const Ok(null);
    } on PostgrestException catch (e) {
      return Err(DatabaseError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }
}