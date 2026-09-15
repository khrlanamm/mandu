import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';
import 'core/constants.dart';
import 'firebase_options.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting('id_ID');
  await GoogleSignIn.instance.initialize(
    serverClientId: AppConstants.googleServerClientId,
  );
  await NotificationService.instance.init();

  runApp(const ManduApp());
}
