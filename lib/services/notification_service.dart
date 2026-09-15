import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../core/constants.dart';
import '../core/navigation.dart';
import '../core/theme/app_colors.dart';
import '../data/repositories/auth_repository.dart';
import '../features/history/history_screen.dart';

/// Notifikasi laporan baru untuk admin.
///
/// Token FCM admin disimpan di `admins/{uid}.fcmToken` (dipakai Cloud Function
/// `sendReportNotification`). Saat aplikasi di background, notifikasi ditampilkan
/// sistem memakai meta-data di AndroidManifest; saat di foreground ditampilkan di sini.
class NotificationService {
  NotificationService._();

  static final instance = NotificationService._();

  static const _channel = AndroidNotificationChannel(
    AppConstants.notificationChannelId,
    AppConstants.notificationChannelName,
    importance: Importance.high,
  );

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  StreamSubscription<String>? _tokenRefreshSubscription;
  bool _launchNotificationHandled = false;

  Future<void> init() async {
    await _localNotifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_stat_mandu'),
      ),
      onDidReceiveNotificationResponse: (_) => _openHistory(),
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    FirebaseMessaging.onMessage.listen(_showForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((_) => _openHistory());
  }

  /// Dipanggil saat Home tampil untuk pengguna yang sudah masuk.
  Future<void> onUserSignedIn(String uid) async {
    await _messaging.requestPermission();
    await _syncAdminToken(uid);
    await _handleLaunchNotification();
  }

  /// Token perangkat dihapus agar notifikasi laporan tidak lagi masuk setelah logout.
  Future<void> onUserSignedOut() async {
    await _tokenRefreshSubscription?.cancel();
    _tokenRefreshSubscription = null;
    try {
      await _messaging.deleteToken();
    } catch (e) {
      debugPrint('Gagal menghapus FCM token: $e');
    }
  }

  Future<void> _syncAdminToken(String uid) async {
    final auth = AuthRepository.instance;
    if (!await auth.isAdmin(uid)) return;

    Future<void> save(String token) async {
      try {
        await auth.saveAdminFcmToken(uid, token);
      } catch (e) {
        debugPrint('Gagal menyimpan FCM token admin: $e');
      }
    }

    final token = await _messaging.getToken();
    if (token != null) await save(token);

    await _tokenRefreshSubscription?.cancel();
    _tokenRefreshSubscription = _messaging.onTokenRefresh.listen(save);
  }

  Future<void> _handleLaunchNotification() async {
    if (_launchNotificationHandled) return;
    _launchNotificationHandled = true;

    final initialMessage = await _messaging.getInitialMessage();
    final launchDetails = await _localNotifications.getNotificationAppLaunchDetails();
    if (initialMessage != null || (launchDetails?.didNotificationLaunchApp ?? false)) {
      _openHistory();
    }
  }

  void _openHistory() {
    if (AuthRepository.instance.currentUser == null) return;
    rootNavigatorKey.currentState?.push(
      MaterialPageRoute<void>(builder: (_) => const HistoryScreen()),
    );
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    final imageUrl = notification.android?.imageUrl;
    final picture = imageUrl == null ? null : await _downloadBitmap(imageUrl);
    final body = notification.body ?? '';

    await _localNotifications.show(
      id: DateTime.now().millisecondsSinceEpoch.remainder(0x7fffffff),
      title: notification.title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          importance: Importance.high,
          priority: Priority.high,
          color: AppColors.tosca,
          styleInformation: picture != null
              ? BigPictureStyleInformation(picture)
              : BigTextStyleInformation(body),
        ),
      ),
    );
  }

  Future<ByteArrayAndroidBitmap?> _downloadBitmap(String url) async {
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 10);
    try {
      final response = await (await client.getUrl(Uri.parse(url))).close();
      if (response.statusCode != HttpStatus.ok) return null;
      return ByteArrayAndroidBitmap(await consolidateHttpClientResponseBytes(response));
    } catch (e) {
      debugPrint('Gagal mengunduh gambar notifikasi: $e');
      return null;
    } finally {
      client.close();
    }
  }
}
