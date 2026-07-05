import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pesantren_management/features/master/models/tahun_ajaran.dart';
import 'package:pesantren_management/features/master/models/kelas.dart';
import 'package:pesantren_management/features/master/models/santri_kelas.dart';
import 'package:pesantren_management/features/master/repo/tahun_ajaran_repo.dart';
import 'package:pesantren_management/features/master/repo/kelas_repo.dart';
import 'package:pesantren_management/features/master/repo/santri_kelas_repo.dart';
import 'package:pesantren_management/shared/providers/supabase_provider.dart';

part 'master_provider.g.dart';

final tahunAjaranRepoProvider = Provider((ref) => TahunAjaranRepo(ref.watch(supabaseClientProvider)));
final kelasRepoProvider = Provider((ref) => KelasRepo(ref.watch(supabaseClientProvider)));
final santiKelasRepoProvider = Provider((ref) => SantriKelasRepo(ref.watch(supabaseClientProvider)));

// ─── Tahun Ajaran ────────────────────────────────────────────────────────────

@riverpod
class TahunAjaranList extends _$TahunAjaranList {
  @override
  Future<List<TahunAjaran>> build({int limit = 50, int offset = 0}) async {
    final result = await ref.read(tahunAjaranRepoProvider).list(limit: limit, offset: offset);
    return result.fold((data) => data, (e) => throw e);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    await future;
  }

  Future<bool> create({required String nama, required DateTime mulai, required DateTime selesai, bool aktif = false}) async {
    state = const AsyncLoading();
    final result = await ref.read(tahunAjaranRepoProvider).create(nama: nama, mulai: mulai, selesai: selesai, aktif: aktif);
    final ok = result.fold((_) => true, (_) => false);
    if (ok) await refresh();
    return ok;
  }

  Future<bool> updateItem(String id, {String? nama, DateTime? mulai, DateTime? selesai, bool? aktif}) async {
    state = const AsyncLoading();
    final result = await ref.read(tahunAjaranRepoProvider).update(id, nama: nama, mulai: mulai, selesai: selesai, aktif: aktif);
    final ok = result.fold((_) => true, (_) => false);
    if (ok) await refresh();
    return ok;
  }

  Future<bool> delete(String id) async {
    state = const AsyncLoading();
    final result = await ref.read(tahunAjaranRepoProvider).delete(id);
    final ok = result.fold((_) => true, (_) => false);
    if (ok) await refresh();
    return ok;
  }
}

@riverpod
class TahunAjaranDetail extends _$TahunAjaranDetail {
  @override
  Future<TahunAjaran?> build(String id) async {
    final result = await ref.read(tahunAjaranRepoProvider).get(id);
    return result.fold((data) => data, (e) => throw e);
  }
}

// ─── Kelas ─────────────────────────────────────────────────────────────────────

@riverpod
class KelasList extends _$KelasList {
  @override
  Future<List<Kelas>> build({String? tahunAjaranId, int limit = 50, int offset = 0}) async {
    final result = await ref.read(kelasRepoProvider).list(tahunAjaranId: tahunAjaranId, limit: limit, offset: offset);
    return result.fold((data) => data, (e) => throw e);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    await future;
  }

  Future<bool> create({required String tahunAjaranId, required String nama, String? waliId, int kapasitas = 30}) async {
    state = const AsyncLoading();
    final result = await ref.read(kelasRepoProvider).create(tahunAjaranId: tahunAjaranId, nama: nama, waliId: waliId, kapasitas: kapasitas);
    final ok = result.fold((_) => true, (_) => false);
    if (ok) await refresh();
    return ok;
  }

  Future<bool> updateItem(String id, {String? nama, String? waliId, int? kapasitas}) async {
    state = const AsyncLoading();
    final result = await ref.read(kelasRepoProvider).update(id, nama: nama, waliId: waliId, kapasitas: kapasitas);
    final ok = result.fold((_) => true, (_) => false);
    if (ok) await refresh();
    return ok;
  }

  Future<bool> delete(String id) async {
    state = const AsyncLoading();
    final result = await ref.read(kelasRepoProvider).delete(id);
    final ok = result.fold((_) => true, (_) => false);
    if (ok) await refresh();
    return ok;
  }
}

@riverpod
class KelasDetail extends _$KelasDetail {
  @override
  Future<Kelas?> build(String id) async {
    final result = await ref.read(kelasRepoProvider).get(id);
    return result.fold((data) => data, (e) => throw e);
  }
}

// ─── Santri Kelas ─────────────────────────────────────────────────────────────

@riverpod
class SantriKelasList extends _$SantriKelasList {
  @override
  Future<List<SantriKelas>> build({String? tahunAjaranId, String? kelasId, String? santriId, int limit = 50, int offset = 0}) async {
    final result = await ref.read(santiKelasRepoProvider).list(tahunAjaranId: tahunAjaranId, kelasId: kelasId, santriId: santriId, limit: limit, offset: offset);
    return result.fold((data) => data, (e) => throw e);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    await future;
  }

  Future<bool> enroll({required String tahunAjaranId, required String santriId, required String kelasId, DateTime? tanggalMasuk, String status = 'aktif'}) async {
    state = const AsyncLoading();
    final result = await ref.read(santiKelasRepoProvider).enroll(tahunAjaranId: tahunAjaranId, santriId: santriId, kelasId: kelasId, tanggalMasuk: tanggalMasuk, status: status);
    final ok = result.fold((_) => true, (_) => false);
    if (ok) await refresh();
    return ok;
  }

  Future<bool> transfer(String id, {required String newKelasId, DateTime? tanggalKeluar}) async {
    state = const AsyncLoading();
    final result = await ref.read(santiKelasRepoProvider).transfer(id, newKelasId: newKelasId, tanggalKeluar: tanggalKeluar);
    final ok = result.fold((_) => true, (_) => false);
    if (ok) await refresh();
    return ok;
  }

  Future<bool> drop(String id, {DateTime? tanggalKeluar}) async {
    state = const AsyncLoading();
    final result = await ref.read(santiKelasRepoProvider).drop(id, tanggalKeluar: tanggalKeluar);
    final ok = result.fold((_) => true, (_) => false);
    if (ok) await refresh();
    return ok;
  }

  Future<bool> delete(String id) async {
    state = const AsyncLoading();
    final result = await ref.read(santiKelasRepoProvider).delete(id);
    final ok = result.fold((_) => true, (_) => false);
    if (ok) await refresh();
    return ok;
  }
}

@riverpod
class SantriKelasDetail extends _$SantriKelasDetail {
  @override
  Future<SantriKelas?> build(String id) async {
    final result = await ref.read(santiKelasRepoProvider).get(id);
    return result.fold((data) => data, (e) => throw e);
  }
}