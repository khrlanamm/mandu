// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(careRepository)
final careRepositoryProvider = CareRepositoryProvider._();

final class CareRepositoryProvider
    extends $FunctionalProvider<CareRepository, CareRepository, CareRepository>
    with $Provider<CareRepository> {
  CareRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'careRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$careRepositoryHash();

  @$internal
  @override
  $ProviderElement<CareRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CareRepository create(Ref ref) {
    return careRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CareRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CareRepository>(value),
    );
  }
}

String _$careRepositoryHash() => r'fc6621ceac13d6e30afaf72b35837d09e561504c';

@ProviderFor(myHelpRequests)
final myHelpRequestsProvider = MyHelpRequestsProvider._();

final class MyHelpRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HelpRequest>>,
          List<HelpRequest>,
          Stream<List<HelpRequest>>
        >
    with
        $FutureModifier<List<HelpRequest>>,
        $StreamProvider<List<HelpRequest>> {
  MyHelpRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myHelpRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myHelpRequestsHash();

  @$internal
  @override
  $StreamProviderElement<List<HelpRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HelpRequest>> create(Ref ref) {
    return myHelpRequests(ref);
  }
}

String _$myHelpRequestsHash() => r'd51eadcb61d22841843e3f32e1162a57ab8e9e71';

@ProviderFor(helpQueue)
final helpQueueProvider = HelpQueueProvider._();

final class HelpQueueProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HelpRequest>>,
          List<HelpRequest>,
          Stream<List<HelpRequest>>
        >
    with
        $FutureModifier<List<HelpRequest>>,
        $StreamProvider<List<HelpRequest>> {
  HelpQueueProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'helpQueueProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$helpQueueHash();

  @$internal
  @override
  $StreamProviderElement<List<HelpRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<HelpRequest>> create(Ref ref) {
    return helpQueue(ref);
  }
}

String _$helpQueueHash() => r'46df9c5b6d8314e8d1a06c426d35a2cea7ea3c82';

@ProviderFor(helpRequest)
final helpRequestProvider = HelpRequestFamily._();

final class HelpRequestProvider
    extends
        $FunctionalProvider<
          AsyncValue<HelpRequest?>,
          HelpRequest?,
          Stream<HelpRequest?>
        >
    with $FutureModifier<HelpRequest?>, $StreamProvider<HelpRequest?> {
  HelpRequestProvider._({
    required HelpRequestFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'helpRequestProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$helpRequestHash();

  @override
  String toString() {
    return r'helpRequestProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<HelpRequest?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<HelpRequest?> create(Ref ref) {
    final argument = this.argument as (String, String);
    return helpRequest(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is HelpRequestProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$helpRequestHash() => r'420a006664b04a09f74b81c0a6bbc673257425c1';

final class HelpRequestFamily extends $Family
    with $FunctionalFamilyOverride<Stream<HelpRequest?>, (String, String)> {
  HelpRequestFamily._()
    : super(
        retry: null,
        name: r'helpRequestProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HelpRequestProvider call(String schoolId, String requestId) =>
      HelpRequestProvider._(argument: (schoolId, requestId), from: this);

  @override
  String toString() => r'helpRequestProvider';
}

@ProviderFor(counselorList)
final counselorListProvider = CounselorListFamily._();

final class CounselorListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Counselor>>,
          List<Counselor>,
          FutureOr<List<Counselor>>
        >
    with $FutureModifier<List<Counselor>>, $FutureProvider<List<Counselor>> {
  CounselorListProvider._({
    required CounselorListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'counselorListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$counselorListHash();

  @override
  String toString() {
    return r'counselorListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Counselor>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Counselor>> create(Ref ref) {
    final argument = this.argument as String;
    return counselorList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CounselorListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$counselorListHash() => r'd92d5d895c0517c917ec49cd9e7a0c0c61ed3726';

final class CounselorListFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Counselor>>, String> {
  CounselorListFamily._()
    : super(
        retry: null,
        name: r'counselorListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CounselorListProvider call(String schoolId) =>
      CounselorListProvider._(argument: schoolId, from: this);

  @override
  String toString() => r'counselorListProvider';
}

@ProviderFor(conversation)
final conversationProvider = ConversationFamily._();

final class ConversationProvider
    extends
        $FunctionalProvider<
          AsyncValue<Conversation?>,
          Conversation?,
          Stream<Conversation?>
        >
    with $FutureModifier<Conversation?>, $StreamProvider<Conversation?> {
  ConversationProvider._({
    required ConversationFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'conversationProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$conversationHash();

  @override
  String toString() {
    return r'conversationProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<Conversation?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Conversation?> create(Ref ref) {
    final argument = this.argument as (String, String);
    return conversation(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$conversationHash() => r'a339f8251e4c0f6f122a1d8a9e1533efdd6418e9';

final class ConversationFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Conversation?>, (String, String)> {
  ConversationFamily._()
    : super(
        retry: null,
        name: r'conversationProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ConversationProvider call(String schoolId, String conversationId) =>
      ConversationProvider._(argument: (schoolId, conversationId), from: this);

  @override
  String toString() => r'conversationProvider';
}

@ProviderFor(myConversations)
final myConversationsProvider = MyConversationsProvider._();

final class MyConversationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Conversation>>,
          List<Conversation>,
          Stream<List<Conversation>>
        >
    with
        $FutureModifier<List<Conversation>>,
        $StreamProvider<List<Conversation>> {
  MyConversationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myConversationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myConversationsHash();

  @$internal
  @override
  $StreamProviderElement<List<Conversation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Conversation>> create(Ref ref) {
    return myConversations(ref);
  }
}

String _$myConversationsHash() => r'8206ccd97db11536e0b2cd6d50afe90817668027';

@ProviderFor(counselorConversations)
final counselorConversationsProvider = CounselorConversationsProvider._();

final class CounselorConversationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Conversation>>,
          List<Conversation>,
          Stream<List<Conversation>>
        >
    with
        $FutureModifier<List<Conversation>>,
        $StreamProvider<List<Conversation>> {
  CounselorConversationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'counselorConversationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$counselorConversationsHash();

  @$internal
  @override
  $StreamProviderElement<List<Conversation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Conversation>> create(Ref ref) {
    return counselorConversations(ref);
  }
}

String _$counselorConversationsHash() =>
    r'b7629418207830f8e0632ca242e80f1a7830a218';

@ProviderFor(waitingConversations)
final waitingConversationsProvider = WaitingConversationsProvider._();

final class WaitingConversationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Conversation>>,
          List<Conversation>,
          Stream<List<Conversation>>
        >
    with
        $FutureModifier<List<Conversation>>,
        $StreamProvider<List<Conversation>> {
  WaitingConversationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'waitingConversationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$waitingConversationsHash();

  @$internal
  @override
  $StreamProviderElement<List<Conversation>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Conversation>> create(Ref ref) {
    return waitingConversations(ref);
  }
}

String _$waitingConversationsHash() =>
    r'2ce153c20156648bc33c3a37a83e0fedad75e03c';

@ProviderFor(conversationMessages)
final conversationMessagesProvider = ConversationMessagesFamily._();

final class ConversationMessagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ChatMessage>>,
          List<ChatMessage>,
          Stream<List<ChatMessage>>
        >
    with
        $FutureModifier<List<ChatMessage>>,
        $StreamProvider<List<ChatMessage>> {
  ConversationMessagesProvider._({
    required ConversationMessagesFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'conversationMessagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$conversationMessagesHash();

  @override
  String toString() {
    return r'conversationMessagesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<ChatMessage>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ChatMessage>> create(Ref ref) {
    final argument = this.argument as (String, String);
    return conversationMessages(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is ConversationMessagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$conversationMessagesHash() =>
    r'c0d428b04b01c4728620ff636625d451bcba4216';

final class ConversationMessagesFamily extends $Family
    with
        $FunctionalFamilyOverride<Stream<List<ChatMessage>>, (String, String)> {
  ConversationMessagesFamily._()
    : super(
        retry: null,
        name: r'conversationMessagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ConversationMessagesProvider call(String schoolId, String conversationId) =>
      ConversationMessagesProvider._(
        argument: (schoolId, conversationId),
        from: this,
      );

  @override
  String toString() => r'conversationMessagesProvider';
}

@ProviderFor(caseNotes)
final caseNotesProvider = CaseNotesFamily._();

final class CaseNotesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CaseNote>>,
          List<CaseNote>,
          Stream<List<CaseNote>>
        >
    with $FutureModifier<List<CaseNote>>, $StreamProvider<List<CaseNote>> {
  CaseNotesProvider._({
    required CaseNotesFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'caseNotesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$caseNotesHash();

  @override
  String toString() {
    return r'caseNotesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<List<CaseNote>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CaseNote>> create(Ref ref) {
    final argument = this.argument as (String, String);
    return caseNotes(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is CaseNotesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$caseNotesHash() => r'4e8fc2fdbc695118955408d01c96eecda5d01d2b';

final class CaseNotesFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<CaseNote>>, (String, String)> {
  CaseNotesFamily._()
    : super(
        retry: null,
        name: r'caseNotesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CaseNotesProvider call(String schoolId, String conversationId) =>
      CaseNotesProvider._(argument: (schoolId, conversationId), from: this);

  @override
  String toString() => r'caseNotesProvider';
}

@ProviderFor(chatImageUrl)
final chatImageUrlProvider = ChatImageUrlFamily._();

final class ChatImageUrlProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  ChatImageUrlProvider._({
    required ChatImageUrlFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatImageUrlProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatImageUrlHash();

  @override
  String toString() {
    return r'chatImageUrlProvider'
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
    return chatImageUrl(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatImageUrlProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatImageUrlHash() => r'd7fad217b638ad5cba8e485730eaa15ea751d5c8';

final class ChatImageUrlFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, String> {
  ChatImageUrlFamily._()
    : super(
        retry: null,
        name: r'chatImageUrlProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatImageUrlProvider call(String path) =>
      ChatImageUrlProvider._(argument: path, from: this);

  @override
  String toString() => r'chatImageUrlProvider';
}

/// Jumlah hal yang menunggu konselor (badge tab Tugas).

@ProviderFor(counselorPendingCount)
final counselorPendingCountProvider = CounselorPendingCountProvider._();

/// Jumlah hal yang menunggu konselor (badge tab Tugas).

final class CounselorPendingCountProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Jumlah hal yang menunggu konselor (badge tab Tugas).
  CounselorPendingCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'counselorPendingCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$counselorPendingCountHash();

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    return counselorPendingCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$counselorPendingCountHash() =>
    r'6099666709787946c697bf7cdb82a7a794e09e99';
