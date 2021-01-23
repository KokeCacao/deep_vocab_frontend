import 'package:deep_vocab/models/sqlite_models/primitive_list_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'dart:convert';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  String uuid;
  String userName;
  DateTime dateTime;
  String message;
  String avatarUrl;
  int likes;
  bool isLike;

  CommentModel(
      {@required this.uuid,
      @required this.userName,
      @required this.dateTime,
      @required this.message,
      @required this.avatarUrl,
      @required this.likes,
      @required this.isLike});

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}

class CommentModelConverter extends TypeConverter<CommentModel, String> {
  const CommentModelConverter();
  @override
  CommentModel mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return CommentModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(CommentModel value) {
    if (value == null) {
      return null;
    }
    return json.encode(value.toJson());
  }
}

class CommentModelListConverter extends TypeConverter<List<CommentModel>, String> {
  const CommentModelListConverter();

  @override
  List<CommentModel> mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    assert(StringListConverter().mapToDart(fromDb).map((e) => CommentModelConverter().mapToDart(e)).isNotEmpty);
    return StringListConverter().mapToDart(fromDb).map((e) => CommentModelConverter().mapToDart(e));
  }

  @override
  String mapToSql(List<CommentModel> value) {
    assert(value.isNotEmpty);
    if (value == null) {
      return null;
    }
    return StringListConverter().mapToSql(value.map((e) => CommentModelConverter().mapToSql(e)));
  }
}
