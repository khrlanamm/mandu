import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import '../domain/catalog.dart';
import '../errors.dart';

/// Berkas yang dipilih pengguna dan belum diunggah.
@immutable
class PendingAttachment {
  const PendingAttachment({required this.name, required this.bytes, required this.contentType});

  final String name;
  final Uint8List bytes;
  final String contentType;

  int get size => bytes.length;

  bool get isImage => contentType.startsWith('image/');
}

const kAttachmentExtensions = ['jpg', 'jpeg', 'png', 'webp', 'heic', 'pdf'];

String? contentTypeFor(String fileName) {
  final extension = fileName.split('.').last.toLowerCase();
  return switch (extension) {
    'jpg' || 'jpeg' => 'image/jpeg',
    'png' => 'image/png',
    'webp' => 'image/webp',
    'heic' => 'image/heic',
    'gif' => 'image/gif',
    'pdf' => 'application/pdf',
    _ => null,
  };
}

String formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(0)} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
}

PendingAttachment _validated(String name, Uint8List bytes) {
  final contentType = contentTypeFor(name);
  if (contentType == null) throw AppException('$name bukan gambar atau PDF.');
  if (bytes.length > kMaxAttachmentBytes) throw AppException('$name lebih dari 10 MB.');
  return PendingAttachment(name: name, bytes: bytes, contentType: contentType);
}

/// Pilih foto atau PDF dari penyimpanan. Maksimal [remaining] berkas.
Future<List<PendingAttachment>> pickAttachmentFiles({required int remaining}) async {
  if (remaining <= 0) return const [];
  final files = await FilePicker.pickFiles(
    type: FileType.custom,
    allowedExtensions: kAttachmentExtensions,
  );
  final picked = <PendingAttachment>[];
  for (final file in files.take(remaining)) {
    picked.add(_validated(file.name, Uint8List.fromList(await file.readAsBytes())));
  }
  return picked;
}

/// Ambil foto dengan kamera (dikompresi agar ringan diunggah).
Future<PendingAttachment?> captureAttachmentPhoto() async {
  final photo = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 80, maxWidth: 2200);
  if (photo == null) return null;
  final name = photo.name.contains('.') ? photo.name : '${photo.name}.jpg';
  return _validated(name, await photo.readAsBytes());
}
