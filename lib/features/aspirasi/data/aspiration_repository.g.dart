// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aspiration_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aspirationRepository)
final aspirationRepositoryProvider = AspirationRepositoryProvider._();

final class AspirationRepositoryProvider
    extends
        $FunctionalProvider<
          AspirationRepository,
          AspirationRepository,
          AspirationRepository
        >
    with $Provider<AspirationRepository> {
  AspirationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aspirationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aspirationRepositoryHash();

  @$internal
  @override
  $ProviderElement<AspirationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AspirationRepository create(Ref ref) {
    return aspirationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AspirationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AspirationRepository>(value),
    );
  }
}

String _$aspirationRepositoryHash() =>
    r'3653fb7af1cebcb5b9015555d3534702f49f69af';

@ProviderFor(aspiration)
final aspirationProvider = AspirationFamily._();

final class AspirationProvider
    extends
        $FunctionalProvider<
          AsyncValue<Aspiration?>,
          Aspiration?,
          Stream<Aspiration?>
        >
    with $FutureModifier<Aspiration?>, $StreamProvider<Aspiration?> {
  AspirationProvider._({
    required AspirationFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'aspirationProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aspirationHash();

  @override
  String toString() {
    return r'aspirationProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<Aspiration?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Aspiration?> create(Ref ref) {
    final argument = this.argument as (String, String);
    return aspiration(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is AspirationProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aspirationHash() => r'69b5889e4e4230169db75a75c58f6754ae0433a3';

final class AspirationFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Aspiration?>, (String, String)> {
  AspirationFamily._()
    : super(
        retry: null,
        name: r'aspirationProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AspirationProvider call(String schoolId, String aspirationId) =>
      AspirationProvider._(argument: (schoolId, aspirationId), from: this);

  @override
  String toString() => r'aspirationProvider';
}

@ProviderFor(aspirationBoard)
final aspirationBoardProvider = AspirationBoardFamily._();

final class AspirationBoardProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Aspiration>>,
          List<Aspiration>,
          Stream<List<Aspiration>>
        >
    with $FutureModifier<List<Aspiration>>, $StreamProvider<List<Aspiration>> {
  AspirationBoardProvider._({
    required AspirationBoardFamily super.from,
    required (String, BoardSort) super.argument,
  }) : super(
         retry: null,
         name: r'aspirationBoardProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aspirationBoardHash();

  @override
  String toString() {
    return r'aspirationBoardProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<Aspiration>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Aspiration>> create(Ref ref) {
    final argument = this.argument as (String, BoardSort);
    return aspirationBoard(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is AspirationBoardProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aspirationBoardHash() => r'd23cebbd1b422c2f36788c7001058403e418caf9';

final class AspirationBoardFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<Aspiration>>,
          (String, BoardSort)
        > {
  AspirationBoardFamily._()
    : super(
        retry: null,
        name: r'aspirationBoardProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AspirationBoardProvider call(String schoolId, BoardSort sort) =>
      AspirationBoardProvider._(argument: (schoolId, sort), from: this);

  @override
  String toString() => r'aspirationBoardProvider';
}

@ProviderFor(aspirationInbox)
final aspirationInboxProvider = AspirationInboxFamily._();

final class AspirationInboxProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Aspiration>>,
          List<Aspiration>,
          Stream<List<Aspiration>>
        >
    with $FutureModifier<List<Aspiration>>, $StreamProvider<List<Aspiration>> {
  AspirationInboxProvider._({
    required AspirationInboxFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'aspirationInboxProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aspirationInboxHash();

  @override
  String toString() {
    return r'aspirationInboxProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Aspiration>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Aspiration>> create(Ref ref) {
    final argument = this.argument as String;
    return aspirationInbox(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AspirationInboxProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aspirationInboxHash() => r'1c7183708ce287493cef7625de5597b80cb143e0';

final class AspirationInboxFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Aspiration>>, String> {
  AspirationInboxFamily._()
    : super(
        retry: null,
        name: r'aspirationInboxProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AspirationInboxProvider call(String schoolId) =>
      AspirationInboxProvider._(argument: schoolId, from: this);

  @override
  String toString() => r'aspirationInboxProvider';
}

@ProviderFor(aspirationIdentity)
final aspirationIdentityProvider = AspirationIdentityFamily._();

final class AspirationIdentityProvider
    extends
        $FunctionalProvider<
          AsyncValue<AspirationIdentity?>,
          AspirationIdentity?,
          Stream<AspirationIdentity?>
        >
    with
        $FutureModifier<AspirationIdentity?>,
        $StreamProvider<AspirationIdentity?> {
  AspirationIdentityProvider._({
    required AspirationIdentityFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'aspirationIdentityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aspirationIdentityHash();

  @override
  String toString() {
    return r'aspirationIdentityProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<AspirationIdentity?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<AspirationIdentity?> create(Ref ref) {
    final argument = this.argument as (String, String);
    return aspirationIdentity(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is AspirationIdentityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aspirationIdentityHash() =>
    r'9e4f4698b47719d2227065d044612dff317e8b85';

final class AspirationIdentityFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<AspirationIdentity?>,
          (String, String)
        > {
  AspirationIdentityFamily._()
    : super(
        retry: null,
        name: r'aspirationIdentityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AspirationIdentityProvider call(String schoolId, String aspirationId) =>
      AspirationIdentityProvider._(
        argument: (schoolId, aspirationId),
        from: this,
      );

  @override
  String toString() => r'aspirationIdentityProvider';
}

@ProviderFor(myAspirations)
final myAspirationsProvider = MyAspirationsProvider._();

final class MyAspirationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AspirationOwner>>,
          List<AspirationOwner>,
          Stream<List<AspirationOwner>>
        >
    with
        $FutureModifier<List<AspirationOwner>>,
        $StreamProvider<List<AspirationOwner>> {
  MyAspirationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myAspirationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myAspirationsHash();

  @$internal
  @override
  $StreamProviderElement<List<AspirationOwner>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<AspirationOwner>> create(Ref ref) {
    return myAspirations(ref);
  }
}

String _$myAspirationsHash() => r'210e5e16f6c032c5afb12120e04d901f01ed74ea';

@ProviderFor(aspirationSupported)
final aspirationSupportedProvider = AspirationSupportedFamily._();

final class AspirationSupportedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  AspirationSupportedProvider._({
    required AspirationSupportedFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'aspirationSupportedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aspirationSupportedHash();

  @override
  String toString() {
    return r'aspirationSupportedProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    final argument = this.argument as (String, String);
    return aspirationSupported(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is AspirationSupportedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aspirationSupportedHash() =>
    r'8c0e2ffa2f3abca0b8e20f609d4c48062babf31a';

final class AspirationSupportedFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, (String, String)> {
  AspirationSupportedFamily._()
    : super(
        retry: null,
        name: r'aspirationSupportedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AspirationSupportedProvider call(String schoolId, String aspirationId) =>
      AspirationSupportedProvider._(
        argument: (schoolId, aspirationId),
        from: this,
      );

  @override
  String toString() => r'aspirationSupportedProvider';
}
