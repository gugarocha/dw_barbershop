// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_employee_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTotalScheduleTodayHash() =>
    r'c02320fd686106440c796a896152193cfac61ee0';

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

typedef GetTotalScheduleTodayRef = AutoDisposeFutureProviderRef<int>;

/// See also [getTotalScheduleToday].
@ProviderFor(getTotalScheduleToday)
const getTotalScheduleTodayProvider = GetTotalScheduleTodayFamily();

/// See also [getTotalScheduleToday].
class GetTotalScheduleTodayFamily extends Family<AsyncValue<int>> {
  /// See also [getTotalScheduleToday].
  const GetTotalScheduleTodayFamily();

  /// See also [getTotalScheduleToday].
  GetTotalScheduleTodayProvider call(
    int userId,
  ) {
    return GetTotalScheduleTodayProvider(
      userId,
    );
  }

  @override
  GetTotalScheduleTodayProvider getProviderOverride(
    covariant GetTotalScheduleTodayProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'getTotalScheduleTodayProvider';
}

/// See also [getTotalScheduleToday].
class GetTotalScheduleTodayProvider extends AutoDisposeFutureProvider<int> {
  /// See also [getTotalScheduleToday].
  GetTotalScheduleTodayProvider(
    this.userId,
  ) : super.internal(
          (ref) => getTotalScheduleToday(
            ref,
            userId,
          ),
          from: getTotalScheduleTodayProvider,
          name: r'getTotalScheduleTodayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getTotalScheduleTodayHash,
          dependencies: GetTotalScheduleTodayFamily._dependencies,
          allTransitiveDependencies:
              GetTotalScheduleTodayFamily._allTransitiveDependencies,
        );

  final int userId;

  @override
  bool operator ==(Object other) {
    return other is GetTotalScheduleTodayProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
