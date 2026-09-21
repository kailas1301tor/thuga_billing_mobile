// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocaleNotifier)
final localeProvider = LocaleNotifierProvider._();

final class LocaleNotifierProvider
    extends $AsyncNotifierProvider<LocaleNotifier, AppLanguage> {
  LocaleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeNotifierHash();

  @$internal
  @override
  LocaleNotifier create() => LocaleNotifier();
}

String _$localeNotifierHash() => r'70f91c11f7184a05811acc4327935021faee26e3';

abstract class _$LocaleNotifier extends $AsyncNotifier<AppLanguage> {
  FutureOr<AppLanguage> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppLanguage>, AppLanguage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppLanguage>, AppLanguage>,
              AsyncValue<AppLanguage>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
