import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/ui_helpers.dart';
import '../../core/widgets/label_chip.dart';
import '../../data/repositories/auth_repository.dart';
import '../../services/notification_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final Future<bool> _isAdmin = AuthRepository.instance.isAdmin();

  Future<void> _logout() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Konfirmasi Keluar',
      message: 'Apakah Anda yakin ingin keluar dari akun ini?',
      confirmLabel: 'Ya, Keluar',
      cancelLabel: 'Batal',
      destructive: true,
    );
    if (!confirmed || !mounted) return;

    final navigator = Navigator.of(context);
    try {
      await NotificationService.instance.onUserSignedOut();
      await AuthRepository.instance.signOut();
      // AuthGate di route pertama sudah berganti ke LoginScreen.
      navigator.popUntil((route) => route.isFirst);
    } catch (e) {
      if (mounted) showSnack(context, 'Terjadi kesalahan saat keluar: ${describeError(e)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthRepository.instance.currentUser;
    final photoUrl = user?.photoURL;
    final logo = Image.asset(AppAssets.appLogo, fit: BoxFit.cover);

    return Scaffold(
      backgroundColor: AppColors.tosca,
      appBar: AppBar(title: const Text('Akun')),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Material(
            elevation: 4,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            color: AppColors.tosca,
            child: SizedBox.square(
              dimension: 120,
              child: photoUrl == null
                  ? logo
                  : CachedNetworkImage(
                      imageUrl: photoUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) => logo,
                    ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.toscaLight,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + MediaQuery.paddingOf(context).bottom),
                children: [
                  Center(
                    child: FutureBuilder<bool>(
                      future: _isAdmin,
                      builder: (context, snapshot) {
                        final isAdmin = snapshot.data;
                        if (isAdmin == null) return const SizedBox(height: 24);
                        return LabelChip(
                          label: isAdmin ? 'ADMIN' : 'PENGGUNA',
                          color: isAdmin ? AppColors.roleWitness : AppColors.statusReported,
                          fontSize: 12,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ProfileField(label: 'Nama', value: user?.displayName ?? '-'),
                  const SizedBox(height: 16),
                  _ProfileField(label: 'Email', value: user?.email ?? '-'),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: () =>
                        showSnack(context, 'Profil hanya bisa diedit melalui akun Google Anda'),
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Ubah Profil'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _logout,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.tosca),
                    ),
                    icon: const Icon(Icons.logout),
                    label: const Text('Keluar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.fieldBorder),
          ),
          child: Text(value, style: const TextStyle(fontSize: 16, color: Colors.black)),
        ),
      ],
    );
  }
}
