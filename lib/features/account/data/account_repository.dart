import 'package:cloud_functions/cloud_functions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/domain/catalog.dart';
import '../../../core/firebase/callable.dart';
import '../../../core/firebase/firebase_providers.dart';
import '../domain/account_summary.dart';

part 'account_repository.g.dart';

class AccountRepository {
  const AccountRepository(this._functions);

  final FirebaseFunctions _functions;

  Future<AccountSummary> sync() async => AccountSummary.fromJson(await _functions.callMap('account-sync'));

  Future<void> acceptConsent() => _functions.callMap('account-acceptConsent', {'version': kConsentVersion});

  Future<void> changeInitialPassword(String newPassword) =>
      _functions.callMap('account-changeInitialPassword', {'newPassword': newPassword});

  Future<void> updateDisplayName(String displayName) =>
      _functions.callMap('account-updateDisplayName', {'displayName': displayName});
}

@Riverpod(keepAlive: true)
AccountRepository accountRepository(Ref ref) => AccountRepository(ref.watch(functionsProvider));
