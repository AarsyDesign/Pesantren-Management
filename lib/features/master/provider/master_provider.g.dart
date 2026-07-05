// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tahunAjaranListHash() => r'cd4027c34050995c2f2775757dc1a1de0a136627';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TahunAjaranList
    extends BuildlessAutoDisposeAsyncNotifier<List<TahunAjaran>> {
  late final int limit;
  late final int offset;

  FutureOr<List<TahunAjaran>> build({int limit = 50, int offset = 0});
}

/// See also [TahunAjaranList].
@ProviderFor(TahunAjaranList)
const tahunAjaranListProvider = TahunAjaranListFamily();

/// See also [TahunAjaranList].
class TahunAjaranListFamily extends Family<AsyncValue<List<TahunAjaran>>> {
  /// See also [TahunAjaranList].
  const TahunAjaranListFamily();

  /// See also [TahunAjaranList].
  TahunAjaranListProvider call({int limit = 50, int offset = 0}) {
    return TahunAjaranListProvider(limit: limit, offset: offset);
  }

  @override
  TahunAjaranListProvider getProviderOverride(
    covariant TahunAjaranListProvider provider,
  ) {
    return call(limit: provider.limit, offset: provider.offset);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tahunAjaranListProvider';
}

/// See also [TahunAjaranList].
class TahunAjaranListProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          TahunAjaranList,
          List<TahunAjaran>
        > {
  /// See also [TahunAjaranList].
  TahunAjaranListProvider({int limit = 50, int offset = 0})
    : this._internal(
        () => TahunAjaranList()
          ..limit = limit
          ..offset = offset,
        from: tahunAjaranListProvider,
        name: r'tahunAjaranListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tahunAjaranListHash,
        dependencies: TahunAjaranListFamily._dependencies,
        allTransitiveDependencies:
            TahunAjaranListFamily._allTransitiveDependencies,
        limit: limit,
        offset: offset,
      );

  TahunAjaranListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
    required this.offset,
  }) : super.internal();

  final int limit;
  final int offset;

  @override
  FutureOr<List<TahunAjaran>> runNotifierBuild(
    covariant TahunAjaranList notifier,
  ) {
    return notifier.build(limit: limit, offset: offset);
  }

  @override
  Override overrideWith(TahunAjaranList Function() create) {
    return ProviderOverride(
      origin: this,
      override: TahunAjaranListProvider._internal(
        () => create()
          ..limit = limit
          ..offset = offset,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
        offset: offset,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TahunAjaranList, List<TahunAjaran>>
  createElement() {
    return _TahunAjaranListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TahunAjaranListProvider &&
        other.limit == limit &&
        other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TahunAjaranListRef
    on AutoDisposeAsyncNotifierProviderRef<List<TahunAjaran>> {
  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `offset` of this provider.
  int get offset;
}

class _TahunAjaranListProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          TahunAjaranList,
          List<TahunAjaran>
        >
    with TahunAjaranListRef {
  _TahunAjaranListProviderElement(super.provider);

  @override
  int get limit => (origin as TahunAjaranListProvider).limit;
  @override
  int get offset => (origin as TahunAjaranListProvider).offset;
}

String _$tahunAjaranDetailHash() => r'a132dc9435991cc3b3529dd65c6bad3efd11bf8a';

abstract class _$TahunAjaranDetail
    extends BuildlessAutoDisposeAsyncNotifier<TahunAjaran?> {
  late final String id;

  FutureOr<TahunAjaran?> build(String id);
}

/// See also [TahunAjaranDetail].
@ProviderFor(TahunAjaranDetail)
const tahunAjaranDetailProvider = TahunAjaranDetailFamily();

/// See also [TahunAjaranDetail].
class TahunAjaranDetailFamily extends Family<AsyncValue<TahunAjaran?>> {
  /// See also [TahunAjaranDetail].
  const TahunAjaranDetailFamily();

  /// See also [TahunAjaranDetail].
  TahunAjaranDetailProvider call(String id) {
    return TahunAjaranDetailProvider(id);
  }

  @override
  TahunAjaranDetailProvider getProviderOverride(
    covariant TahunAjaranDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tahunAjaranDetailProvider';
}

/// See also [TahunAjaranDetail].
class TahunAjaranDetailProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<TahunAjaranDetail, TahunAjaran?> {
  /// See also [TahunAjaranDetail].
  TahunAjaranDetailProvider(String id)
    : this._internal(
        () => TahunAjaranDetail()..id = id,
        from: tahunAjaranDetailProvider,
        name: r'tahunAjaranDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$tahunAjaranDetailHash,
        dependencies: TahunAjaranDetailFamily._dependencies,
        allTransitiveDependencies:
            TahunAjaranDetailFamily._allTransitiveDependencies,
        id: id,
      );

  TahunAjaranDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<TahunAjaran?> runNotifierBuild(
    covariant TahunAjaranDetail notifier,
  ) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(TahunAjaranDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: TahunAjaranDetailProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TahunAjaranDetail, TahunAjaran?>
  createElement() {
    return _TahunAjaranDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TahunAjaranDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TahunAjaranDetailRef
    on AutoDisposeAsyncNotifierProviderRef<TahunAjaran?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TahunAjaranDetailProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<TahunAjaranDetail, TahunAjaran?>
    with TahunAjaranDetailRef {
  _TahunAjaranDetailProviderElement(super.provider);

  @override
  String get id => (origin as TahunAjaranDetailProvider).id;
}

String _$kelasListHash() => r'47864c55e33c1d45e1e9b56b7aa3b4ec02fd444e';

abstract class _$KelasList
    extends BuildlessAutoDisposeAsyncNotifier<List<Kelas>> {
  late final String? tahunAjaranId;
  late final int limit;
  late final int offset;

  FutureOr<List<Kelas>> build({
    String? tahunAjaranId,
    int limit = 50,
    int offset = 0,
  });
}

/// See also [KelasList].
@ProviderFor(KelasList)
const kelasListProvider = KelasListFamily();

/// See also [KelasList].
class KelasListFamily extends Family<AsyncValue<List<Kelas>>> {
  /// See also [KelasList].
  const KelasListFamily();

  /// See also [KelasList].
  KelasListProvider call({
    String? tahunAjaranId,
    int limit = 50,
    int offset = 0,
  }) {
    return KelasListProvider(
      tahunAjaranId: tahunAjaranId,
      limit: limit,
      offset: offset,
    );
  }

  @override
  KelasListProvider getProviderOverride(covariant KelasListProvider provider) {
    return call(
      tahunAjaranId: provider.tahunAjaranId,
      limit: provider.limit,
      offset: provider.offset,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'kelasListProvider';
}

/// See also [KelasList].
class KelasListProvider
    extends AutoDisposeAsyncNotifierProviderImpl<KelasList, List<Kelas>> {
  /// See also [KelasList].
  KelasListProvider({String? tahunAjaranId, int limit = 50, int offset = 0})
    : this._internal(
        () => KelasList()
          ..tahunAjaranId = tahunAjaranId
          ..limit = limit
          ..offset = offset,
        from: kelasListProvider,
        name: r'kelasListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$kelasListHash,
        dependencies: KelasListFamily._dependencies,
        allTransitiveDependencies: KelasListFamily._allTransitiveDependencies,
        tahunAjaranId: tahunAjaranId,
        limit: limit,
        offset: offset,
      );

  KelasListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tahunAjaranId,
    required this.limit,
    required this.offset,
  }) : super.internal();

  final String? tahunAjaranId;
  final int limit;
  final int offset;

  @override
  FutureOr<List<Kelas>> runNotifierBuild(covariant KelasList notifier) {
    return notifier.build(
      tahunAjaranId: tahunAjaranId,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Override overrideWith(KelasList Function() create) {
    return ProviderOverride(
      origin: this,
      override: KelasListProvider._internal(
        () => create()
          ..tahunAjaranId = tahunAjaranId
          ..limit = limit
          ..offset = offset,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tahunAjaranId: tahunAjaranId,
        limit: limit,
        offset: offset,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<KelasList, List<Kelas>>
  createElement() {
    return _KelasListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is KelasListProvider &&
        other.tahunAjaranId == tahunAjaranId &&
        other.limit == limit &&
        other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tahunAjaranId.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin KelasListRef on AutoDisposeAsyncNotifierProviderRef<List<Kelas>> {
  /// The parameter `tahunAjaranId` of this provider.
  String? get tahunAjaranId;

  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `offset` of this provider.
  int get offset;
}

class _KelasListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<KelasList, List<Kelas>>
    with KelasListRef {
  _KelasListProviderElement(super.provider);

  @override
  String? get tahunAjaranId => (origin as KelasListProvider).tahunAjaranId;
  @override
  int get limit => (origin as KelasListProvider).limit;
  @override
  int get offset => (origin as KelasListProvider).offset;
}

String _$kelasDetailHash() => r'ae2ff5be7f01a98e187615303f78370b1b978f8d';

abstract class _$KelasDetail extends BuildlessAutoDisposeAsyncNotifier<Kelas?> {
  late final String id;

  FutureOr<Kelas?> build(String id);
}

/// See also [KelasDetail].
@ProviderFor(KelasDetail)
const kelasDetailProvider = KelasDetailFamily();

/// See also [KelasDetail].
class KelasDetailFamily extends Family<AsyncValue<Kelas?>> {
  /// See also [KelasDetail].
  const KelasDetailFamily();

  /// See also [KelasDetail].
  KelasDetailProvider call(String id) {
    return KelasDetailProvider(id);
  }

  @override
  KelasDetailProvider getProviderOverride(
    covariant KelasDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'kelasDetailProvider';
}

/// See also [KelasDetail].
class KelasDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<KelasDetail, Kelas?> {
  /// See also [KelasDetail].
  KelasDetailProvider(String id)
    : this._internal(
        () => KelasDetail()..id = id,
        from: kelasDetailProvider,
        name: r'kelasDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$kelasDetailHash,
        dependencies: KelasDetailFamily._dependencies,
        allTransitiveDependencies: KelasDetailFamily._allTransitiveDependencies,
        id: id,
      );

  KelasDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<Kelas?> runNotifierBuild(covariant KelasDetail notifier) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(KelasDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: KelasDetailProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<KelasDetail, Kelas?> createElement() {
    return _KelasDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is KelasDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin KelasDetailRef on AutoDisposeAsyncNotifierProviderRef<Kelas?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _KelasDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<KelasDetail, Kelas?>
    with KelasDetailRef {
  _KelasDetailProviderElement(super.provider);

  @override
  String get id => (origin as KelasDetailProvider).id;
}

String _$santriKelasListHash() => r'54e27f9d6c5bf9a30ce4e5e27c7bf663038dea7b';

abstract class _$SantriKelasList
    extends BuildlessAutoDisposeAsyncNotifier<List<SantriKelas>> {
  late final String? tahunAjaranId;
  late final String? kelasId;
  late final String? santriId;
  late final int limit;
  late final int offset;

  FutureOr<List<SantriKelas>> build({
    String? tahunAjaranId,
    String? kelasId,
    String? santriId,
    int limit = 50,
    int offset = 0,
  });
}

/// See also [SantriKelasList].
@ProviderFor(SantriKelasList)
const santriKelasListProvider = SantriKelasListFamily();

/// See also [SantriKelasList].
class SantriKelasListFamily extends Family<AsyncValue<List<SantriKelas>>> {
  /// See also [SantriKelasList].
  const SantriKelasListFamily();

  /// See also [SantriKelasList].
  SantriKelasListProvider call({
    String? tahunAjaranId,
    String? kelasId,
    String? santriId,
    int limit = 50,
    int offset = 0,
  }) {
    return SantriKelasListProvider(
      tahunAjaranId: tahunAjaranId,
      kelasId: kelasId,
      santriId: santriId,
      limit: limit,
      offset: offset,
    );
  }

  @override
  SantriKelasListProvider getProviderOverride(
    covariant SantriKelasListProvider provider,
  ) {
    return call(
      tahunAjaranId: provider.tahunAjaranId,
      kelasId: provider.kelasId,
      santriId: provider.santriId,
      limit: provider.limit,
      offset: provider.offset,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'santriKelasListProvider';
}

/// See also [SantriKelasList].
class SantriKelasListProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          SantriKelasList,
          List<SantriKelas>
        > {
  /// See also [SantriKelasList].
  SantriKelasListProvider({
    String? tahunAjaranId,
    String? kelasId,
    String? santriId,
    int limit = 50,
    int offset = 0,
  }) : this._internal(
         () => SantriKelasList()
           ..tahunAjaranId = tahunAjaranId
           ..kelasId = kelasId
           ..santriId = santriId
           ..limit = limit
           ..offset = offset,
         from: santriKelasListProvider,
         name: r'santriKelasListProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$santriKelasListHash,
         dependencies: SantriKelasListFamily._dependencies,
         allTransitiveDependencies:
             SantriKelasListFamily._allTransitiveDependencies,
         tahunAjaranId: tahunAjaranId,
         kelasId: kelasId,
         santriId: santriId,
         limit: limit,
         offset: offset,
       );

  SantriKelasListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tahunAjaranId,
    required this.kelasId,
    required this.santriId,
    required this.limit,
    required this.offset,
  }) : super.internal();

  final String? tahunAjaranId;
  final String? kelasId;
  final String? santriId;
  final int limit;
  final int offset;

  @override
  FutureOr<List<SantriKelas>> runNotifierBuild(
    covariant SantriKelasList notifier,
  ) {
    return notifier.build(
      tahunAjaranId: tahunAjaranId,
      kelasId: kelasId,
      santriId: santriId,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Override overrideWith(SantriKelasList Function() create) {
    return ProviderOverride(
      origin: this,
      override: SantriKelasListProvider._internal(
        () => create()
          ..tahunAjaranId = tahunAjaranId
          ..kelasId = kelasId
          ..santriId = santriId
          ..limit = limit
          ..offset = offset,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tahunAjaranId: tahunAjaranId,
        kelasId: kelasId,
        santriId: santriId,
        limit: limit,
        offset: offset,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SantriKelasList, List<SantriKelas>>
  createElement() {
    return _SantriKelasListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SantriKelasListProvider &&
        other.tahunAjaranId == tahunAjaranId &&
        other.kelasId == kelasId &&
        other.santriId == santriId &&
        other.limit == limit &&
        other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tahunAjaranId.hashCode);
    hash = _SystemHash.combine(hash, kelasId.hashCode);
    hash = _SystemHash.combine(hash, santriId.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SantriKelasListRef
    on AutoDisposeAsyncNotifierProviderRef<List<SantriKelas>> {
  /// The parameter `tahunAjaranId` of this provider.
  String? get tahunAjaranId;

  /// The parameter `kelasId` of this provider.
  String? get kelasId;

  /// The parameter `santriId` of this provider.
  String? get santriId;

  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `offset` of this provider.
  int get offset;
}

class _SantriKelasListProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          SantriKelasList,
          List<SantriKelas>
        >
    with SantriKelasListRef {
  _SantriKelasListProviderElement(super.provider);

  @override
  String? get tahunAjaranId =>
      (origin as SantriKelasListProvider).tahunAjaranId;
  @override
  String? get kelasId => (origin as SantriKelasListProvider).kelasId;
  @override
  String? get santriId => (origin as SantriKelasListProvider).santriId;
  @override
  int get limit => (origin as SantriKelasListProvider).limit;
  @override
  int get offset => (origin as SantriKelasListProvider).offset;
}

String _$santriKelasDetailHash() => r'8d1b99cbbffc7947d55d2c6bc5c869f1ef6f2f49';

abstract class _$SantriKelasDetail
    extends BuildlessAutoDisposeAsyncNotifier<SantriKelas?> {
  late final String id;

  FutureOr<SantriKelas?> build(String id);
}

/// See also [SantriKelasDetail].
@ProviderFor(SantriKelasDetail)
const santriKelasDetailProvider = SantriKelasDetailFamily();

/// See also [SantriKelasDetail].
class SantriKelasDetailFamily extends Family<AsyncValue<SantriKelas?>> {
  /// See also [SantriKelasDetail].
  const SantriKelasDetailFamily();

  /// See also [SantriKelasDetail].
  SantriKelasDetailProvider call(String id) {
    return SantriKelasDetailProvider(id);
  }

  @override
  SantriKelasDetailProvider getProviderOverride(
    covariant SantriKelasDetailProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'santriKelasDetailProvider';
}

/// See also [SantriKelasDetail].
class SantriKelasDetailProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<SantriKelasDetail, SantriKelas?> {
  /// See also [SantriKelasDetail].
  SantriKelasDetailProvider(String id)
    : this._internal(
        () => SantriKelasDetail()..id = id,
        from: santriKelasDetailProvider,
        name: r'santriKelasDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$santriKelasDetailHash,
        dependencies: SantriKelasDetailFamily._dependencies,
        allTransitiveDependencies:
            SantriKelasDetailFamily._allTransitiveDependencies,
        id: id,
      );

  SantriKelasDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<SantriKelas?> runNotifierBuild(
    covariant SantriKelasDetail notifier,
  ) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(SantriKelasDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: SantriKelasDetailProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SantriKelasDetail, SantriKelas?>
  createElement() {
    return _SantriKelasDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SantriKelasDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SantriKelasDetailRef
    on AutoDisposeAsyncNotifierProviderRef<SantriKelas?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SantriKelasDetailProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<SantriKelasDetail, SantriKelas?>
    with SantriKelasDetailRef {
  _SantriKelasDetailProviderElement(super.provider);

  @override
  String get id => (origin as SantriKelasDetailProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
