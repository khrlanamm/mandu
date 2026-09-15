import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../firebase_options.dart';
import 'app.dart';
import 'env.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (Env.useEmulators) await _useEmulators();

  await initializeDateFormatting('id_ID');
  if (!kIsWeb) {
    await GoogleSignIn.instance.initialize(serverClientId: Env.googleServerClientId);
  }

  runApp(const ProviderScope(child: ManduApp()));
}

Future<void> _useEmulators() async {
  final host = Env.emulatorHost.isNotEmpty
      ? Env.emulatorHost
      : (!kIsWeb && defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2' : 'localhost');

  await FirebaseAuth.instance.useAuthEmulator(host, 9099);
  FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
  FirebaseFunctions.instanceFor(region: Env.functionsRegion).useFunctionsEmulator(host, 5001);
  await FirebaseStorage.instance.useStorageEmulator(host, 9199);
  debugPrint('MANDU memakai Firebase Emulator Suite di $host');
}
