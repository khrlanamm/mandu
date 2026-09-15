import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../app/router.dart';
import '../../auth/application/session_controller.dart';
import '../data/notification_repository.dart';

part 'push_controller.g.dart';

/// Kanal Android, sama dengan functions/src/notifications/notify.ts.
const _urgentChannel = AndroidNotificationChannel(
  'mandu_urgent',
  'Darurat',
  description: 'Laporan darurat dan permintaan bantuan mendesak',
  importance: Importance.max,
);
const _updatesChannel = AndroidNotificationChannel(
  'mandu_updates',
  'Pembaruan laporan',
  description: 'Perkembangan laporan, tugas baru, dan pengingat batas waktu',
  importance: Importance.high,
);

bool get _pushSupported => !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

/// Mendaftarkan token FCM perangkat untuk akun yang masuk dan membuka rute saat notifikasi diketuk.
@Riverpod(keepAlive: true)
class PushController extends _$PushController {
  final _local = FlutterLocalNotificationsPlugin();
  final _subscriptions = <StreamSubscription<Object?>>[];
  bool _initialized = false;
  String? _registeredUid;
  String? _token;

  @override
  void build() {
    if (!_pushSupported) return;
    ref.listen<Session>(sessionControllerProvider, (_, next) => _onSession(next), fireImmediately: true);
    ref.onDispose(() {
      for (final subscription in _subscriptions) {
        subscription.cancel();
      }
    });
  }

  Future<void> _onSession(Session session) async {
    if (session is! SignedIn) return;
    final account = session.account;
    if ((!account.isActiveMember && !account.isSuperadmin) || _registeredUid == account.uid) return;
    _registeredUid = account.uid;

    try {
      await _initialize();
      final permission = await FirebaseMessaging.instance.requestPermission();
      if (permission.authorizationStatus == AuthorizationStatus.denied) return;
      final token = await FirebaseMessaging.instance.getToken();
      if (token == null) return;
      _token = token;
      await ref.read(notificationRepositoryProvider).registerDevice(token: token, platform: 'android');

      final initial = await FirebaseMessaging.instance.getInitialMessage();
      if (initial != null) {
        await Future<void>.delayed(const Duration(milliseconds: 600));
        _open(initial.data['route'] as String?);
      }
    } catch (error) {
      _registeredUid = null;
      debugPrint('Registrasi notifikasi gagal: $error');
    }
  }

  Future<void> _initialize() async {
    if (_initialized) return;
    _initialized = true;

    await _local.initialize(
      settings: const InitializationSettings(android: AndroidInitializationSettings('ic_stat_mandu')),
      onDidReceiveNotificationResponse: (response) => _open(response.payload),
    );
    final android = _local.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await android?.createNotificationChannel(_urgentChannel);
    await android?.createNotificationChannel(_updatesChannel);

    _subscriptions
      ..add(FirebaseMessaging.onMessage.listen(_showForeground))
      ..add(FirebaseMessaging.onMessageOpenedApp.listen((message) => _open(message.data['route'] as String?)))
      ..add(FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
        _token = token;
        if (_registeredUid == null) return;
        try {
          await ref.read(notificationRepositoryProvider).registerDevice(token: token, platform: 'android');
        } catch (error) {
          debugPrint('Perbarui token notifikasi gagal: $error');
        }
      }));
  }

  /// Push saat aplikasi terbuka tidak ditampilkan sistem, jadi tampilkan sebagai notifikasi lokal.
  Future<void> _showForeground(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;
    final channel = notification.android?.channelId == _urgentChannel.id ? _urgentChannel : _updatesChannel;
    await _local.show(
      id: message.messageId.hashCode & 0x7fffffff,
      title: notification.title,
      body: notification.body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: channel.importance,
          priority: channel == _urgentChannel ? Priority.max : Priority.high,
          icon: 'ic_stat_mandu',
        ),
      ),
      payload: message.data['route'] as String?,
    );
  }

  void _open(String? route) {
    if (route == null || !route.startsWith('/')) return;
    ref.read(routerProvider).push(route);
  }

  /// Lepas token perangkat sebelum keluar agar notifikasi akun ini tidak lagi masuk ke perangkat.
  Future<void> unregister() async {
    final token = _token;
    _registeredUid = null;
    _token = null;
    if (!_pushSupported || token == null) return;
    try {
      // Batas waktu agar keluar akun tidak tertahan saat jaringan/Play Services lambat.
      await ref.read(notificationRepositoryProvider).unregisterDevice(token).timeout(const Duration(seconds: 5));
      await FirebaseMessaging.instance.deleteToken().timeout(const Duration(seconds: 5));
    } catch (error) {
      debugPrint('Lepas token notifikasi gagal: $error');
    }
  }
}
