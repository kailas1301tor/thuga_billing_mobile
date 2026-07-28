// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReportsNotifier)
final reportsProvider = ReportsNotifierProvider._();

final class ReportsNotifierProvider
    extends $NotifierProvider<ReportsNotifier, ReportsState> {
  ReportsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsNotifierHash();

  @$internal
  @override
  ReportsNotifier create() => ReportsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsState>(value),
    );
  }
}

String _$reportsNotifierHash() => r'03f3e0b9bdadba651c21e30e923ede24de1854e4';

abstract class _$ReportsNotifier extends $Notifier<ReportsState> {
  ReportsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReportsState, ReportsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReportsState, ReportsState>,
              ReportsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
