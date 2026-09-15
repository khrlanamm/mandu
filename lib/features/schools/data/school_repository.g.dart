// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(schoolRepository)
final schoolRepositoryProvider = SchoolRepositoryProvider._();

final class SchoolRepositoryProvider
    extends
        $FunctionalProvider<
          SchoolRepository,
          SchoolRepository,
          SchoolRepository
        >
    with $Provider<SchoolRepository> {
  SchoolRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'schoolRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$schoolRepositoryHash();

  @$internal
  @override
  $ProviderElement<SchoolRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SchoolRepository create(Ref ref) {
    return schoolRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SchoolRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SchoolRepository>(value),
    );
  }
}

String _$schoolRepositoryHash() => r'1635605184586faccc279ec6a003ea13107ee72d';

/// Informasi publik sekolah dari kode (aspirasi tanpa login).

@ProviderFor(publicSchool)
final publicSchoolProvider = PublicSchoolFamily._();

/// Informasi publik sekolah dari kode (aspirasi tanpa login).

final class PublicSchoolProvider
    extends
        $FunctionalProvider<
          AsyncValue<PublicSchool>,
          PublicSchool,
          FutureOr<PublicSchool>
        >
    with $FutureModifier<PublicSchool>, $FutureProvider<PublicSchool> {
  /// Informasi publik sekolah dari kode (aspirasi tanpa login).
  PublicSchoolProvider._({
    required PublicSchoolFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'publicSchoolProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicSchoolHash();

  @override
  String toString() {
    return r'publicSchoolProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PublicSchool> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PublicSchool> create(Ref ref) {
    final argument = this.argument as String;
    return publicSchool(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicSchoolProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicSchoolHash() => r'1b490a28fbd47b1eb96f2ed5b35f74bf57226953';

/// Informasi publik sekolah dari kode (aspirasi tanpa login).

final class PublicSchoolFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PublicSchool>, String> {
  PublicSchoolFamily._()
    : super(
        retry: null,
        name: r'publicSchoolProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Informasi publik sekolah dari kode (aspirasi tanpa login).

  PublicSchoolProvider call(String code) =>
      PublicSchoolProvider._(argument: code, from: this);

  @override
  String toString() => r'publicSchoolProvider';
}

@ProviderFor(schoolDoc)
final schoolDocProvider = SchoolDocFamily._();

final class SchoolDocProvider
    extends $FunctionalProvider<AsyncValue<School?>, School?, Stream<School?>>
    with $FutureModifier<School?>, $StreamProvider<School?> {
  SchoolDocProvider._({
    required SchoolDocFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'schoolDocProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$schoolDocHash();

  @override
  String toString() {
    return r'schoolDocProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<School?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<School?> create(Ref ref) {
    final argument = this.argument as String;
    return schoolDoc(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SchoolDocProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$schoolDocHash() => r'4e6f1276a2df895e3388b1354eac30e239b945e0';

final class SchoolDocFamily extends $Family
    with $FunctionalFamilyOverride<Stream<School?>, String> {
  SchoolDocFamily._()
    : super(
        retry: null,
        name: r'schoolDocProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SchoolDocProvider call(String schoolId) =>
      SchoolDocProvider._(argument: schoolId, from: this);

  @override
  String toString() => r'schoolDocProvider';
}

@ProviderFor(schoolUnits)
final schoolUnitsProvider = SchoolUnitsFamily._();

final class SchoolUnitsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SchoolUnit>>,
          List<SchoolUnit>,
          Stream<List<SchoolUnit>>
        >
    with $FutureModifier<List<SchoolUnit>>, $StreamProvider<List<SchoolUnit>> {
  SchoolUnitsProvider._({
    required SchoolUnitsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'schoolUnitsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$schoolUnitsHash();

  @override
  String toString() {
    return r'schoolUnitsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<SchoolUnit>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<SchoolUnit>> create(Ref ref) {
    final argument = this.argument as String;
    return schoolUnits(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SchoolUnitsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$schoolUnitsHash() => r'a60dfa8b293db46bec5d8b8cc76ca08d24f2d4d4';

final class SchoolUnitsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<SchoolUnit>>, String> {
  SchoolUnitsFamily._()
    : super(
        retry: null,
        name: r'schoolUnitsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SchoolUnitsProvider call(String schoolId) =>
      SchoolUnitsProvider._(argument: schoolId, from: this);

  @override
  String toString() => r'schoolUnitsProvider';
}

@ProviderFor(allSchools)
final allSchoolsProvider = AllSchoolsProvider._();

final class AllSchoolsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<School>>,
          List<School>,
          Stream<List<School>>
        >
    with $FutureModifier<List<School>>, $StreamProvider<List<School>> {
  AllSchoolsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allSchoolsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allSchoolsHash();

  @$internal
  @override
  $StreamProviderElement<List<School>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<School>> create(Ref ref) {
    return allSchools(ref);
  }
}

String _$allSchoolsHash() => r'2ebbb10bfb63f6223726b9dfb7211d334c531319';
