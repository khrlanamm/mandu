// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: json['id'] as String,
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      route: json['route'] as String? ?? '',
      schoolId: json['schoolId'] as String?,
      ticketId: json['ticketId'] as String?,
      urgent: json['urgent'] as bool? ?? false,
      read: json['read'] as bool? ?? false,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'body': instance.body,
      'route': instance.route,
      'schoolId': instance.schoolId,
      'ticketId': instance.ticketId,
      'urgent': instance.urgent,
      'read': instance.read,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
