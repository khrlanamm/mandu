import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/firebase/callable.dart';

part 'care.freezed.dart';
part 'care.g.dart';

/// Salinan dari functions/src/domain/care.ts — ubah keduanya bersamaan.
const kHelpNeeds = {
  'ingin_bicara': 'Ingin bicara dengan seseorang',
  'tidak_aman': 'Merasa tidak aman',
  'keluarga': 'Masalah keluarga',
  'teman': 'Masalah pertemanan',
  'belajar': 'Tekanan belajar',
  'perasaan': 'Sedih, cemas, atau kewalahan',
  'belum_siap': 'Belum siap cerita',
};

enum HelpUrgency {
  biasa('Bisa menunggu', 'Konselor menghubungi dalam beberapa hari'),
  segera('Hari ini', 'Perlu ditangani hari ini juga'),
  darurat('Sekarang juga', 'Aku butuh bantuan saat ini');

  const HelpUrgency(this.label, this.description);

  final String label;
  final String description;
}

enum ContactMethod {
  chat('Chat di aplikasi', Icons.forum_outlined),
  bertemu('Bertemu langsung', Icons.handshake_outlined),
  whatsapp('WhatsApp', Icons.phone_iphone_rounded);

  const ContactMethod(this.label, this.icon);

  final String label;
  final IconData icon;
}

enum ContactTime {
  istirahat('Saat jam istirahat'),
  @JsonValue('pulang_sekolah')
  pulangSekolah('Setelah pulang sekolah'),
  @JsonValue('kapan_saja')
  kapanSaja('Kapan saja');

  const ContactTime(this.label);

  final String label;

  String get wire => switch (this) {
        ContactTime.pulangSekolah => 'pulang_sekolah',
        ContactTime.kapanSaja => 'kapan_saja',
        ContactTime.istirahat => 'istirahat',
      };
}

enum HelpStatus {
  menunggu('Menunggu konselor'),
  ditangani('Sedang ditangani'),
  selesai('Selesai'),
  dibatalkan('Dibatalkan');

  const HelpStatus(this.label);

  final String label;

  bool get isOpen => this == menunggu || this == ditangani;
}

/// Dokumen `schools/{schoolId}/helpRequests/{id}`.
@freezed
abstract class HelpRequest with _$HelpRequest {
  const HelpRequest._();

  const factory HelpRequest({
    required String id,
    @Default('') String number,
    @Default('') String schoolId,
    @Default('') String studentUid,
    @Default(HelpStudent()) HelpStudent student,
    @Default(<String>[]) List<String> needs,
    @JsonKey(unknownEnumValue: HelpUrgency.biasa) @Default(HelpUrgency.biasa) HelpUrgency urgency,
    @JsonKey(unknownEnumValue: ContactMethod.chat) @Default(ContactMethod.chat) ContactMethod contactMethod,
    @JsonKey(unknownEnumValue: ContactTime.kapanSaja) @Default(ContactTime.kapanSaja) ContactTime contactTime,
    String? whatsapp,
    String? note,
    @JsonKey(unknownEnumValue: HelpStatus.menunggu) @Default(HelpStatus.menunggu) HelpStatus status,
    String? counselorUid,
    String? counselorName,
    String? conversationId,
    String? closingNote,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? claimedAt,
    @TimestampConverter() DateTime? closedAt,
  }) = _HelpRequest;

  factory HelpRequest.fromJson(Map<String, dynamic> json) => _$HelpRequestFromJson(json);

  List<String> get needLabels => [for (final need in needs) kHelpNeeds[need] ?? need];
}

@freezed
abstract class HelpStudent with _$HelpStudent {
  const factory HelpStudent({@Default('') String name, String? kelas}) = _HelpStudent;

  factory HelpStudent.fromJson(Map<String, dynamic> json) => _$HelpStudentFromJson(json);
}

enum ConversationStatus {
  menunggu('Menunggu konselor'),
  aktif('Berlangsung'),
  selesai('Selesai');

  const ConversationStatus(this.label);

  final String label;
}

enum MessageRole { siswa, konselor, sistem }

@freezed
abstract class LastMessage with _$LastMessage {
  const factory LastMessage({
    @Default('') String text,
    @JsonKey(unknownEnumValue: MessageRole.sistem) @Default(MessageRole.sistem) MessageRole senderRole,
    @TimestampConverter() DateTime? at,
  }) = _LastMessage;

  factory LastMessage.fromJson(Map<String, dynamic> json) => _$LastMessageFromJson(json);
}

@freezed
abstract class MeetingPlan with _$MeetingPlan {
  const factory MeetingPlan({
    @TimestampConverter() DateTime? at,
    @Default('') String place,
    @Default('diusulkan') String status,
  }) = _MeetingPlan;

  factory MeetingPlan.fromJson(Map<String, dynamic> json) => _$MeetingPlanFromJson(json);
}

/// Dokumen `schools/{schoolId}/conversations/{id}`.
@freezed
abstract class Conversation with _$Conversation {
  const Conversation._();

  const factory Conversation({
    required String id,
    @Default('') String schoolId,
    @Default('') String studentUid,
    @Default('') String displayName,
    @Default(false) bool usesAlias,
    @Default(false) bool identityRevealed,
    String? counselorUid,
    String? counselorName,
    @JsonKey(unknownEnumValue: ConversationStatus.menunggu) @Default(ConversationStatus.menunggu) ConversationStatus status,
    String? topic,
    LastMessage? lastMessage,
    @Default(0) int unreadStudent,
    @Default(0) int unreadCounselor,
    MeetingPlan? meeting,
    String? helpRequestId,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? closedAt,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);

  bool get isOpen => status != ConversationStatus.selesai;

  bool get fromHelpRequest => helpRequestId != null;
}

/// Dokumen `schools/{schoolId}/conversations/{id}/messages/{messageId}`.
@freezed
abstract class ChatMessage with _$ChatMessage {
  const ChatMessage._();

  const factory ChatMessage({
    required String id,
    String? senderUid,
    @JsonKey(unknownEnumValue: MessageRole.sistem) @Default(MessageRole.sistem) MessageRole senderRole,
    @Default('') String text,
    String? imagePath,
    @TimestampConverter() DateTime? createdAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

  bool get isSystem => senderRole == MessageRole.sistem;
}

@freezed
abstract class CaseNote with _$CaseNote {
  const factory CaseNote({
    required String id,
    @Default('') String text,
    @Default('tidak_ada') String riskLevel,
    @Default('') String authorName,
    @TimestampConverter() DateTime? createdAt,
  }) = _CaseNote;

  factory CaseNote.fromJson(Map<String, dynamic> json) => _$CaseNoteFromJson(json);
}

const kRiskLevels = {
  'tidak_ada': 'Tidak ada tanda risiko',
  'perhatian': 'Perlu perhatian',
  'tinggi': 'Risiko tinggi',
};

/// Kontak bantuan darurat nasional (ditampilkan di Curhat dan Butuh Bantuan).
class EmergencyContact {
  const EmergencyContact({required this.name, required this.number, required this.description});

  final String name;
  final String number;
  final String description;
}

const kEmergencyContacts = [
  EmergencyContact(name: 'Panggilan darurat', number: '112', description: 'Polisi, ambulans, pemadam kebakaran'),
  EmergencyContact(name: 'SAPA Kementerian PPPA', number: '129', description: 'Kekerasan pada perempuan dan anak'),
  EmergencyContact(name: 'Sehat Jiwa Kemenkes', number: '119', description: 'Layanan kesehatan jiwa, tekan ext. 8'),
];

/// Isian formulir Butuh Bantuan.
class HelpDraft {
  const HelpDraft({
    required this.needs,
    required this.urgency,
    required this.contactMethod,
    required this.contactTime,
    this.whatsapp,
    this.note,
  });

  final List<String> needs;
  final HelpUrgency urgency;
  final ContactMethod contactMethod;
  final ContactTime contactTime;
  final String? whatsapp;
  final String? note;
}
