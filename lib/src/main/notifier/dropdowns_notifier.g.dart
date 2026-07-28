// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdowns_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DropdownsNotifier)
final dropdownsProvider = DropdownsNotifierProvider._();

final class DropdownsNotifierProvider
    extends $NotifierProvider<DropdownsNotifier, DropdownsState> {
  DropdownsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dropdownsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dropdownsNotifierHash();

  @$internal
  @override
  DropdownsNotifier create() => DropdownsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DropdownsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DropdownsState>(value),
    );
  }
}

String _$dropdownsNotifierHash() => r'd64ea4a08c2f033d63e5ba585223e7fe18cba021';

abstract class _$DropdownsNotifier extends $Notifier<DropdownsState> {
  DropdownsState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DropdownsState, DropdownsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DropdownsState, DropdownsState>,
              DropdownsState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
