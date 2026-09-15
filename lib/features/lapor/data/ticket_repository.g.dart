// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ticketRepository)
final ticketRepositoryProvider = TicketRepositoryProvider._();

final class TicketRepositoryProvider
    extends
        $FunctionalProvider<
          TicketRepository,
          TicketRepository,
          TicketRepository
        >
    with $Provider<TicketRepository> {
  TicketRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketRepositoryHash();

  @$internal
  @override
  $ProviderElement<TicketRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TicketRepository create(Ref ref) {
    return ticketRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TicketRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TicketRepository>(value),
    );
  }
}

String _$ticketRepositoryHash() => r'299aa1993d4b5bb7cf667a113f7d8c697017cd24';

@ProviderFor(ticket)
final ticketProvider = TicketFamily._();

final class TicketProvider
    extends $FunctionalProvider<AsyncValue<Ticket?>, Ticket?, Stream<Ticket?>>
    with $FutureModifier<Ticket?>, $StreamProvider<Ticket?> {
  TicketProvider._({
    required TicketFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'ticketProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ticketHash();

  @override
  String toString() {
    return r'ticketProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<Ticket?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Ticket?> create(Ref ref) {
    final argument = this.argument as (String, String);
    return ticket(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is TicketProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ticketHash() => r'058c5cf6122ce1bc01c7f7104ce6fe1bb3c3c5e8';

final class TicketFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Ticket?>, (String, String)> {
  TicketFamily._()
    : super(
        retry: null,
        name: r'ticketProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TicketProvider call(String schoolId, String ticketId) =>
      TicketProvider._(argument: (schoolId, ticketId), from: this);

  @override
  String toString() => r'ticketProvider';
}

@ProviderFor(ticketTimeline)
final ticketTimelineProvider = TicketTimelineFamily._();

final class TicketTimelineProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TimelineEvent>>,
          List<TimelineEvent>,
          Stream<List<TimelineEvent>>
        >
    with
        $FutureModifier<List<TimelineEvent>>,
        $StreamProvider<List<TimelineEvent>> {
  TicketTimelineProvider._({
    required TicketTimelineFamily super.from,
    required (String, String, {bool publicOnly}) super.argument,
  }) : super(
         retry: null,
         name: r'ticketTimelineProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ticketTimelineHash();

  @override
  String toString() {
    return r'ticketTimelineProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<TimelineEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TimelineEvent>> create(Ref ref) {
    final argument = this.argument as (String, String, {bool publicOnly});
    return ticketTimeline(
      ref,
      argument.$1,
      argument.$2,
      publicOnly: argument.publicOnly,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TicketTimelineProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ticketTimelineHash() => r'ea1dda7eaa8f86934670e45fa5c83ea27240d101';

final class TicketTimelineFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<List<TimelineEvent>>,
          (String, String, {bool publicOnly})
        > {
  TicketTimelineFamily._()
    : super(
        retry: null,
        name: r'ticketTimelineProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TicketTimelineProvider call(
    String schoolId,
    String ticketId, {
    required bool publicOnly,
  }) => TicketTimelineProvider._(
    argument: (schoolId, ticketId, publicOnly: publicOnly),
    from: this,
  );

  @override
  String toString() => r'ticketTimelineProvider';
}

@ProviderFor(attachmentUrl)
final attachmentUrlProvider = AttachmentUrlFamily._();

final class AttachmentUrlProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  AttachmentUrlProvider._({
    required AttachmentUrlFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'attachmentUrlProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$attachmentUrlHash();

  @override
  String toString() {
    return r'attachmentUrlProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as String;
    return attachmentUrl(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AttachmentUrlProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$attachmentUrlHash() => r'9e3d9352296abe3577766bafbde962735543e91d';

final class AttachmentUrlFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, String> {
  AttachmentUrlFamily._()
    : super(
        retry: null,
        name: r'attachmentUrlProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AttachmentUrlProvider call(String path) =>
      AttachmentUrlProvider._(argument: path, from: this);

  @override
  String toString() => r'attachmentUrlProvider';
}

/// Laporan milik siswa yang sedang masuk.

@ProviderFor(myTickets)
final myTicketsProvider = MyTicketsProvider._();

/// Laporan milik siswa yang sedang masuk.

final class MyTicketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TicketOwner>>,
          List<TicketOwner>,
          Stream<List<TicketOwner>>
        >
    with
        $FutureModifier<List<TicketOwner>>,
        $StreamProvider<List<TicketOwner>> {
  /// Laporan milik siswa yang sedang masuk.
  MyTicketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myTicketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myTicketsHash();

  @$internal
  @override
  $StreamProviderElement<List<TicketOwner>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TicketOwner>> create(Ref ref) {
    return myTickets(ref);
  }
}

String _$myTicketsHash() => r'35e4d5d0c6a93c401c9fe53622554b25295430a2';

@ProviderFor(staffTicketAccess)
final staffTicketAccessProvider = StaffTicketAccessProvider._();

final class StaffTicketAccessProvider
    extends
        $FunctionalProvider<
          StaffTicketAccess?,
          StaffTicketAccess?,
          StaffTicketAccess?
        >
    with $Provider<StaffTicketAccess?> {
  StaffTicketAccessProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffTicketAccessProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffTicketAccessHash();

  @$internal
  @override
  $ProviderElement<StaffTicketAccess?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StaffTicketAccess? create(Ref ref) {
    return staffTicketAccess(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StaffTicketAccess? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StaffTicketAccess?>(value),
    );
  }
}

String _$staffTicketAccessHash() => r'9fb4695f82efed7f959e6ec3749ef4f7f337cdc4';

@ProviderFor(staffTickets)
final staffTicketsProvider = StaffTicketsProvider._();

final class StaffTicketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Ticket>>,
          List<Ticket>,
          Stream<List<Ticket>>
        >
    with $FutureModifier<List<Ticket>>, $StreamProvider<List<Ticket>> {
  StaffTicketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffTicketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffTicketsHash();

  @$internal
  @override
  $StreamProviderElement<List<Ticket>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Ticket>> create(Ref ref) {
    return staffTickets(ref);
  }
}

String _$staffTicketsHash() => r'50f5cc78123d307a294501157d35aa0b6d6a987a';

/// Jumlah laporan yang menunggu tindakan staf yang sedang masuk (badge tab Tugas).

@ProviderFor(staffActionableCount)
final staffActionableCountProvider = StaffActionableCountProvider._();

/// Jumlah laporan yang menunggu tindakan staf yang sedang masuk (badge tab Tugas).

final class StaffActionableCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Jumlah laporan yang menunggu tindakan staf yang sedang masuk (badge tab Tugas).
  StaffActionableCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffActionableCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffActionableCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return staffActionableCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$staffActionableCountHash() =>
    r'47e388f01b97878b6ea8bff193cdec19aa037bff';
