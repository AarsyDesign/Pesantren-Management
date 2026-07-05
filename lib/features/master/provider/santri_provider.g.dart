// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'santri_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$santriListHash() => r'cc0b90e4fd3041214a5af585afd1938e305dc776';

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

abstract class _$SantriList
    extends BuildlessAutoDisposeAsyncNotifier<List<Santri>> {
  late final String? search;
  late final String? status;
  late final int limit;
  late final int offset;

  FutureOr<List<Santri>> build({
    String? search,
    String? status,
    int limit = 50,
    int offset = 0,
  });
}

/// See also [SantriList].
@ProviderFor(SantriList)
const santriListProvider = SantriListFamily();

/// See also [SantriList].
class SantriListFamily extends Family<AsyncValue<List<Santri>>> {
  /// See also [SantriList].
  const SantriListFamily();

  /// See also [SantriList].
  SantriListProvider call({
    String? search,
    String? status,
    int limit = 50,
    int offset = 0,
  }) {
    return SantriListProvider(
      search: search,
      status: status,
      limit: limit,
      offset: offset,
    );
  }

  @override
  SantriListProvider getProviderOverride(
    covariant SantriListProvider provider,
  ) {
    return call(
      search: provider.search,
      status: provider.status,
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
  String? get name => r'santriListProvider';
}

/// See also [SantriList].
class SantriListProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SantriList, List<Santri>> {
  /// See also [SantriList].
  SantriListProvider({
    String? search,
    String? status,
    int limit = 50,
    int offset = 0,
  }) : this._internal(
         () => SantriList()
           ..search = search
           ..status = status
           ..limit = limit
           ..offset = offset,
         from: santriListProvider,
         name: r'santriListProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$santriListHash,
         dependencies: SantriListFamily._dependencies,
         allTransitiveDependencies: SantriListFamily._allTransitiveDependencies,
         search: search,
         status: status,
         limit: limit,
         offset: offset,
       );

  SantriListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.search,
    required this.status,
    required this.limit,
    required this.offset,
  }) : super.internal();

  final String? search;
  final String? status;
  final int limit;
  final int offset;

  @override
  FutureOr<List<Santri>> runNotifierBuild(covariant SantriList notifier) {
    return notifier.build(
      search: search,
      status: status,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Override overrideWith(SantriList Function() create) {
    return ProviderOverride(
      origin: this,
      override: SantriListProvider._internal(
        () => create()
          ..search = search
          ..status = status
          ..limit = limit
          ..offset = offset,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        search: search,
        status: status,
        limit: limit,
        offset: offset,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SantriList, List<Santri>>
  createElement() {
    return _SantriListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SantriListProvider &&
        other.search == search &&
        other.status == status &&
        other.limit == limit &&
        other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);
    hash = _SystemHash.combine(hash, status.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SantriListRef on AutoDisposeAsyncNotifierProviderRef<List<Santri>> {
  /// The parameter `search` of this provider.
  String? get search;

  /// The parameter `status` of this provider.
  String? get status;

  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `offset` of this provider.
  int get offset;
}

class _SantriListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SantriList, List<Santri>>
    with SantriListRef {
  _SantriListProviderElement(super.provider);

  @override
  String? get search => (origin as SantriListProvider).search;
  @override
  String? get status => (origin as SantriListProvider).status;
  @override
  int get limit => (origin as SantriListProvider).limit;
  @override
  int get offset => (origin as SantriListProvider).offset;
}

String _$santriDetailHash() => r'3a425cd6f29aff79bc7bf1df2d228802b8f5133a';

abstract class _$SantriDetail
    extends BuildlessAutoDisposeAsyncNotifier<Santri?> {
  late final String id;

  FutureOr<Santri?> build(String id);
}

/// Single santri detail
///
/// Copied from [SantriDetail].
@ProviderFor(SantriDetail)
const santriDetailProvider = SantriDetailFamily();

/// Single santri detail
///
/// Copied from [SantriDetail].
class SantriDetailFamily extends Family<AsyncValue<Santri?>> {
  /// Single santri detail
  ///
  /// Copied from [SantriDetail].
  const SantriDetailFamily();

  /// Single santri detail
  ///
  /// Copied from [SantriDetail].
  SantriDetailProvider call(String id) {
    return SantriDetailProvider(id);
  }

  @override
  SantriDetailProvider getProviderOverride(
    covariant SantriDetailProvider provider,
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
  String? get name => r'santriDetailProvider';
}

/// Single santri detail
///
/// Copied from [SantriDetail].
class SantriDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SantriDetail, Santri?> {
  /// Single santri detail
  ///
  /// Copied from [SantriDetail].
  SantriDetailProvider(String id)
    : this._internal(
        () => SantriDetail()..id = id,
        from: santriDetailProvider,
        name: r'santriDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$santriDetailHash,
        dependencies: SantriDetailFamily._dependencies,
        allTransitiveDependencies:
            SantriDetailFamily._allTransitiveDependencies,
        id: id,
      );

  SantriDetailProvider._internal(
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
  FutureOr<Santri?> runNotifierBuild(covariant SantriDetail notifier) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(SantriDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: SantriDetailProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<SantriDetail, Santri?>
  createElement() {
    return _SantriDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SantriDetailProvider && other.id == id;
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
mixin SantriDetailRef on AutoDisposeAsyncNotifierProviderRef<Santri?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SantriDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SantriDetail, Santri?>
    with SantriDetailRef {
  _SantriDetailProviderElement(super.provider);

  @override
  String get id => (origin as SantriDetailProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
