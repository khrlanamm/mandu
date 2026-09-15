import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:json_annotation/json_annotation.dart';

extension ManduCallable on FirebaseFunctions {
  /// Panggil callable function MANDU (mis. `members-join`) dan kembalikan hasil sebagai JSON map.
  Future<Map<String, dynamic>> callMap(String name, [Map<String, Object?> data = const {}]) async {
    final result = await httpsCallable(
      name,
      options: HttpsCallableOptions(timeout: const Duration(seconds: 90)),
    ).call<Object?>(data);
    return jsonMap(result.data);
  }
}

/// Normalisasi Map dari platform channel menjadi `Map<String, dynamic>` bertingkat.
Map<String, dynamic> jsonMap(Object? value) {
  if (value is! Map) return <String, dynamic>{};
  return value.map((key, item) => MapEntry(key.toString(), _jsonValue(item)));
}

Object? _jsonValue(Object? value) => switch (value) {
      Map() => jsonMap(value),
      List() => value.map(_jsonValue).toList(),
      _ => value,
    };

/// Data dokumen Firestore dengan ID dokumen di field [idField].
Map<String, dynamic> docWithId(DocumentSnapshot<Map<String, dynamic>> snapshot, [String idField = 'id']) =>
    {...?snapshot.data(), idField: snapshot.id};

/// Timestamp Firestore ⇄ DateTime untuk model freezed/json_serializable.
class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) => switch (json) {
        Timestamp timestamp => timestamp.toDate(),
        String text => DateTime.tryParse(text),
        int millis => DateTime.fromMillisecondsSinceEpoch(millis),
        _ => null,
      };

  @override
  Object? toJson(DateTime? date) => date == null ? null : Timestamp.fromDate(date);
}
