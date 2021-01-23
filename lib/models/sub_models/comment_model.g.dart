// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
    uuid: json['uuid'] as String,
    userName: json['userName'] as String,
    dateTime: json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
    message: json['message'] as String,
    avatarUrl: json['avatarUrl'] as String,
    likes: json['likes'] as int,
    isLike: json['isLike'] as bool,
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'userName': instance.userName,
      'dateTime': instance.dateTime?.toIso8601String(),
      'message': instance.message,
      'avatarUrl': instance.avatarUrl,
      'likes': instance.likes,
      'isLike': instance.isLike,
    };
