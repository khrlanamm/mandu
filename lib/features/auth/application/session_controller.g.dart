// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Status login + profil MANDU. Memantau `users/{uid}.claimsVersion` agar
/// perubahan peran (mis. disetujui admin) langsung berlaku tanpa login ulang.

@ProviderFor(SessionController)
final sessionControllerProvider = SessionControllerProvider._();

/// Status login + profil MANDU. Memantau `users/{uid}.claimsVersion` agar
/// perubahan peran (mis. disetujui admin) langsung berlaku tanpa login ulang.
final class SessionControllerProvider
    extends $NotifierProvider<SessionController, Session> {
  /// Status login + profil MANDU. Memantau `users/{uid}.claimsVersion` agar
  /// perubahan peran (mis. disetujui admin) langsung berlaku tanpa login ulang.
  SessionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionControllerHash();

  @$internal
  @override
  SessionController create() => SessionController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Session value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Session>(value),
    );
  }
}

String _$sessionControllerHash() => r'5563c43efcb244a47fdcd4ada19581f63a2b5791';

/// Status login + profil MANDU. Memantau `users/{uid}.claimsVersion` agar
/// perubahan peran (mis. disetujui admin) langsung berlaku tanpa login ulang.

abstract class _$SessionController extends $Notifier<Session> {
  Session build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Session, Session>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Session, Session>,
              Session,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(currentAccount)
final currentAccountProvider = CurrentAccountProvider._();

final class CurrentAccountProvider
    extends
        $FunctionalProvider<AccountSummary?, AccountSummary?, AccountSummary?>
    with $Provider<AccountSummary?> {
  CurrentAccountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentAccountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentAccountHash();

  @$internal
  @override
  $ProviderElement<AccountSummary?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AccountSummary? create(Ref ref) {
    return currentAccount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountSummary? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountSummary?>(value),
    );
  }
}

String _$currentAccountHash() => r'60210138c802005d01923ba6fc18c17b59a2c19b';
