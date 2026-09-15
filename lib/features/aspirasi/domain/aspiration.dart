import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/firebase/callable.dart';

part 'aspiration.freezed.dart';
part 'aspiration.g.dart';

/// Salinan dari functions/src/domain/aspirations.ts — ubah keduanya bersamaan.
enum AspirationType {
  saran('Saran', 'Masukan untuk memperbaiki sesuatu', Icons.tips_and_updates_outlined),
  ide('Ide', 'Gagasan baru untuk sekolah', Icons.lightbulb_outline_rounded),
  usulan('Usulan', 'Permintaan kegiatan atau fasilitas', Icons.how_to_vote_outlined),
  kritik('Kritik konstruktif', 'Hal yang perlu dibenahi, disampaikan dengan baik', Icons.rate_review_outlined);

  const AspirationType(this.label, this.description, this.icon);

  final String label;
  final String description;
  final IconData icon;
}

enum AspirationStatus {
  diterima('Diterima'),
  ditinjau('Sedang ditinjau'),
  ditindaklanjuti('Ditindaklanjuti'),
  direalisasikan('Direalisasikan'),
  @JsonValue('belum_dapat')
  belumDapat('Belum dapat ditindaklanjuti');

  const AspirationStatus(this.label);

  final String label;

  String get wire => this == belumDapat ? 'belum_dapat' : name;
}

enum BoardState {
  none('Belum diputuskan'),
  published('Tampil di papan'),
  hidden('Tidak ditampilkan');

  const BoardState(this.label);

  final String label;
}

const kAspirationTopics = {
  'fasilitas': 'Fasilitas & sarana',
  'pembelajaran': 'Pembelajaran',
  'kegiatan': 'Kegiatan & ekstrakurikuler',
  'lingkungan': 'Kebersihan & lingkungan',
  'kantin': 'Kantin',
  'layanan': 'Layanan sekolah',
  'kebijakan': 'Aturan & kebijakan',
  'lainnya': 'Lainnya',
};

@freezed
abstract class AspirationResponse with _$AspirationResponse {
  const factory AspirationResponse({
    required String message,
    @Default('') String respondedByName,
    @TimestampConverter() DateTime? respondedAt,
  }) = _AspirationResponse;

  factory AspirationResponse.fromJson(Map<String, dynamic> json) => _$AspirationResponseFromJson(json);
}

/// Dokumen `schools/{schoolId}/aspirations/{id}` (tanpa identitas pengirim).
@freezed
abstract class Aspiration with _$Aspiration {
  const Aspiration._();

  const factory Aspiration({
    required String id,
    @Default('') String number,
    @Default('') String schoolId,
    @JsonKey(unknownEnumValue: AspirationType.saran) @Default(AspirationType.saran) AspirationType type,
    @Default('lainnya') String topic,
    @Default('') String topicLabel,
    @Default('') String title,
    @Default('') String content,
    @Default('siswa') String source,
    @Default(false) bool anonymous,
    @Default(false) bool flagged,
    @JsonKey(unknownEnumValue: AspirationStatus.diterima) @Default(AspirationStatus.diterima) AspirationStatus status,
    AspirationResponse? response,
    @JsonKey(unknownEnumValue: BoardState.none) @Default(BoardState.none) BoardState board,
    @TimestampConverter() DateTime? publishedAt,
    @Default(0) int supportCount,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _Aspiration;

  factory Aspiration.fromJson(Map<String, dynamic> json) => _$AspirationFromJson(json);

  bool get fromGuest => source == 'tamu';
}

@freezed
abstract class AspirationIdentity with _$AspirationIdentity {
  const factory AspirationIdentity({required String name, String? kelas}) = _AspirationIdentity;

  factory AspirationIdentity.fromJson(Map<String, dynamic> json) => _$AspirationIdentityFromJson(json);
}

@freezed
abstract class AspirationOwner with _$AspirationOwner {
  const factory AspirationOwner({required String id, required String uid, @TimestampConverter() DateTime? createdAt}) =
      _AspirationOwner;

  factory AspirationOwner.fromJson(Map<String, dynamic> json) => _$AspirationOwnerFromJson(json);
}

/// Isian formulir aspirasi.
class AspirationDraft {
  const AspirationDraft({required this.type, required this.topic, required this.title, required this.content, this.anonymous = false});

  final AspirationType type;
  final String topic;
  final String title;
  final String content;
  final bool anonymous;

  Map<String, Object?> toJson() => {'type': type.name, 'topic': topic, 'title': title.trim(), 'content': content.trim()};
}
