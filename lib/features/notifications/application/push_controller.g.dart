// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mendaftarkan token FCM perangkat untuk akun yang masuk dan membuka rute saat notifikasi diketuk.

@ProviderFor(PushController)
final pushControllerProvider = PushControllerProvider._();

/// Mendaftarkan token FCM perangkat untuk akun yang masuk dan membuka rute saat notifikasi diketuk.
final class PushControllerProvider
    extends $NotifierProvider<PushController, void> {
  /// Mendaftarkan token FCM perangkat untuk akun yang masuk dan membuka rute saat notifikasi diketuk.
  PushControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushControllerHash();

  @$internal
  @override
  PushController create() => PushController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$pushControllerHash() => r'1097c5be2b27e8d878bdd9fc301818c8a367835d';

/// Mendaftarkan token FCM perangkat untuk akun yang masuk dan membuka rute saat notifikasi diketuk.

abstract class _$PushController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
