import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/firebase/callable.dart';

part 'app_notification.freezed.dart';
part 'app_notification.g.dart';

/// Dokumen `users/{uid}/notifications/{id}` (functions/src/notifications/notify.ts).
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    @Default('') String type,
    @Default('') String title,
    @Default('') String body,
    @Default('') String route,
    String? schoolId,
    String? ticketId,
    @Default(false) bool urgent,
    @Default(false) bool read,
    @TimestampConverter() DateTime? createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);
}
