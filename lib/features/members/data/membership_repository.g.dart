// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(membershipRepository)
final membershipRepositoryProvider = MembershipRepositoryProvider._();

final class MembershipRepositoryProvider
    extends
        $FunctionalProvider<
          MembershipRepository,
          MembershipRepository,
          MembershipRepository
        >
    with $Provider<MembershipRepository> {
  MembershipRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'membershipRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$membershipRepositoryHash();

  @$internal
  @override
  $ProviderElement<MembershipRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MembershipRepository create(Ref ref) {
    return membershipRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MembershipRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MembershipRepository>(value),
    );
  }
}

String _$membershipRepositoryHash() =>
    r'4cef94f672ae43ec1ae1045799a62b232aed69b9';

@ProviderFor(ownMembership)
final ownMembershipProvider = OwnMembershipFamily._();

final class OwnMembershipProvider
    extends $FunctionalProvider<AsyncValue<Member?>, Member?, Stream<Member?>>
    with $FutureModifier<Member?>, $StreamProvider<Member?> {
  OwnMembershipProvider._({
    required OwnMembershipFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'ownMembershipProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ownMembershipHash();

  @override
  String toString() {
    return r'ownMembershipProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<Member?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Member?> create(Ref ref) {
    final argument = this.argument as (String, String);
    return ownMembership(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is OwnMembershipProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ownMembershipHash() => r'4def7247a5e2f5d7c1d7b5d9f0551c8373539991';

final class OwnMembershipFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Member?>, (String, String)> {
  OwnMembershipFamily._()
    : super(
        retry: null,
        name: r'ownMembershipProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OwnMembershipProvider call(String schoolId, String uid) =>
      OwnMembershipProvider._(argument: (schoolId, uid), from: this);

  @override
  String toString() => r'ownMembershipProvider';
}

@ProviderFor(schoolMember)
final schoolMemberProvider = SchoolMemberFamily._();

final class SchoolMemberProvider
    extends $FunctionalProvider<AsyncValue<Member?>, Member?, Stream<Member?>>
    with $FutureModifier<Member?>, $StreamProvider<Member?> {
  SchoolMemberProvider._({
    required SchoolMemberFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'schoolMemberProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$schoolMemberHash();

  @override
  String toString() {
    return r'schoolMemberProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<Member?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Member?> create(Ref ref) {
    final argument = this.argument as (String, String);
    return schoolMember(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is SchoolMemberProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$schoolMemberHash() => r'4a00df6b5e64ca5c82006da1ab62f3e6a2dad758';

final class SchoolMemberFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Member?>, (String, String)> {
  SchoolMemberFamily._()
    : super(
        retry: null,
        name: r'schoolMemberProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SchoolMemberProvider call(String schoolId, String uid) =>
      SchoolMemberProvider._(argument: (schoolId, uid), from: this);

  @override
  String toString() => r'schoolMemberProvider';
}

@ProviderFor(schoolMembers)
final schoolMembersProvider = SchoolMembersFamily._();

final class SchoolMembersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Member>>,
          List<Member>,
          Stream<List<Member>>
        >
    with $FutureModifier<List<Member>>, $StreamProvider<List<Member>> {
  SchoolMembersProvider._({
    required SchoolMembersFamily super.from,
    required (String, {MemberStatus? status}) super.argument,
  }) : super(
         retry: null,
         name: r'schoolMembersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$schoolMembersHash();

  @override
  String toString() {
    return r'schoolMembersProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<Member>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Member>> create(Ref ref) {
    final argument = this.argument as (String, {MemberStatus? status});
    return schoolMembers(ref, argument.$1, status: argument.status);
  }

  @override
  bool operator ==(Object other) {
    return other is SchoolMembersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$schoolMembersHash() => r'a7a4469d58f35cba5349503f9ff9ad731ac10549';

final class SchoolMembersFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<Member>>,
          (String, {MemberStatus? status})
        > {
  SchoolMembersFamily._()
    : super(
        retry: null,
        name: r'schoolMembersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SchoolMembersProvider call(String schoolId, {MemberStatus? status}) =>
      SchoolMembersProvider._(argument: (schoolId, status: status), from: this);

  @override
  String toString() => r'schoolMembersProvider';
}

@ProviderFor(pendingInvitations)
final pendingInvitationsProvider = PendingInvitationsFamily._();

final class PendingInvitationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Invitation>>,
          List<Invitation>,
          Stream<List<Invitation>>
        >
    with $FutureModifier<List<Invitation>>, $StreamProvider<List<Invitation>> {
  PendingInvitationsProvider._({
    required PendingInvitationsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pendingInvitationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pendingInvitationsHash();

  @override
  String toString() {
    return r'pendingInvitationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<Invitation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Invitation>> create(Ref ref) {
    final argument = this.argument as String;
    return pendingInvitations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PendingInvitationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pendingInvitationsHash() =>
    r'944cd58fb7e4bd545216d525c19e7d26f02cc086';

final class PendingInvitationsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<Invitation>>, String> {
  PendingInvitationsFamily._()
    : super(
        retry: null,
        name: r'pendingInvitationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PendingInvitationsProvider call(String schoolId) =>
      PendingInvitationsProvider._(argument: schoolId, from: this);

  @override
  String toString() => r'pendingInvitationsProvider';
}
