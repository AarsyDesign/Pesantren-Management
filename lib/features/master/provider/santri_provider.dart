import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pesantren_management/features/master/models/santri.dart';
import 'package:pesantren_management/features/master/repo/santri_repo.dart';
import 'package:pesantren_management/shared/providers/supabase_provider.dart';

part 'santri_provider.g.dart';

final santriRepoProvider = Provider<SantriRepo>((ref) => SantriRepo(ref.watch(supabaseClientProvider)));

@riverpod
class SantriList extends _$SantriList {
  @override
  Future<List<Santri>> build({
    String? search,
    String? status,
    int limit = 50,
    int offset = 0,
  }) async {
    final result = await ref
        .read(santriRepoProvider)
        .list(search: search, status: status, limit: limit, offset: offset);
    return result.fold((data) => data, (error) => throw error);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    await future;
  }

  Future<bool> create({
    required String nis,
    required String nama,
    String? tanggalLahir,
    String? jenisKelamin,
    String? alamat,
    String? telepon,
    String status = 'aktif',
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(santriRepoProvider).create(
          nis: nis,
          nama: nama,
          tanggalLahir: tanggalLahir,
          jenisKelamin: jenisKelamin,
          alamat: alamat,
          telepon: telepon,
          status: status,
        );
    final success = result.fold((_) => true, (e) => false);
    if (success) await refresh();
    return success;
  }

  Future<bool> updateSantri(
    String id, {
    String? nis,
    String? nama,
    String? tanggalLahir,
    String? jenisKelamin,
    String? alamat,
    String? telepon,
    String? status,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(santriRepoProvider).update(
          id,
          nis: nis,
          nama: nama,
          tanggalLahir: tanggalLahir,
          jenisKelamin: jenisKelamin,
          alamat: alamat,
          telepon: telepon,
          status: status,
        );
    final success = result.fold((_) => true, (e) => false);
    if (success) await refresh();
    return success;
  }

  Future<bool> delete(String id) async {
    state = const AsyncLoading();
    final result = await ref.read(santriRepoProvider).delete(id);
    final success = result.fold((_) => true, (e) => false);
    if (success) await refresh();
    return success;
  }

  Future<bool> restore(String id) async {
    state = const AsyncLoading();
    final result = await ref.read(santriRepoProvider).restore(id);
    final success = result.fold((_) => true, (e) => false);
    if (success) await refresh();
    return success;
  }
}

/// Single santri detail
@riverpod
class SantriDetail extends _$SantriDetail {
  @override
  Future<Santri?> build(String id) async {
    final result = await ref.read(santriRepoProvider).get(id);
    return result.fold((data) => data, (error) => throw error);
  }
}