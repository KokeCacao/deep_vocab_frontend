import 'package:deep_vocab/models/sub_models/comment_model.dart';
import 'package:deep_vocab/models/sub_models/mark_color_model.dart';
import 'package:deep_vocab/models/vocab_model.dart';
import 'package:moor_flutter/moor_flutter.dart';

class GlobalValueSerializer extends ValueSerializer {
  @Deprecated("Don't use this serializer on DAO, use models instead.")
  const GlobalValueSerializer();

  @override
  T fromJson<T>(dynamic json) {
    if (json == null) {
      return null;
    }

    if (T == DateTime) {
      return DateTime.fromMillisecondsSinceEpoch(json as int) as T;
    }

    if (T == double && json is int) {
      return json.toDouble() as T;
    }

    // blobs are encoded as a regular json array, so we manually convert that to
    // a Uint8List
    if (T == Uint8List && json is! Uint8List) {
      final asList = (json as List).cast<int>();
      return Uint8List.fromList(asList) as T;
    }

    // other cases needed for your app ...

    // See: https://stackoverflow.com/questions/55738674/dart-using-is-operator-to-check-generic-type
    if (List<CommentModel>() is T) return (json as List<Map<String, dynamic>>).map((e) => CommentModel.fromJson(e)).toList() as T;
    if (List<MarkColorModel>() is T) return (json as List<Map<String, dynamic>>).map((e) => MarkColorModel.fromJson(e)).toList() as T;
    if (T == VocabType) return VocabType.values[json as int] as T; // not sure


    return json as T;
  }

  @override
  dynamic toJson<T>(T value) {
    if (value is DateTime) {
      return value.millisecondsSinceEpoch;
    }

    // other cases needed for your app
    if (value is List<CommentModel>) return value.map((e) => e.toJson()).toList();
    if (value is List<CommentModel>) return value.map((e) => e.toJson()).toList();
    if (value is VocabType) return value.index;


    return value;
  }
}