import 'dart:convert';

import 'package:deep_vocab/models/sqlite_models/primitive_list_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'mark_color_model.g.dart';

@JsonSerializable()
class MarkColorModel {
  ColorModel color;
  DateTime time;

  MarkColorModel({@required this.color, @required this.time});

  factory MarkColorModel.fromJson(Map<String, dynamic> json) => _$MarkColorModelFromJson(json);
  Map<String, dynamic> toJson() => _$MarkColorModelToJson(this);
}

enum ColorModel {
  black,
  red,
  yellow,
  green,
}

class MarkColorModelConverter extends TypeConverter<MarkColorModel, String> {
  const MarkColorModelConverter();
  @override
  MarkColorModel mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return MarkColorModel.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(MarkColorModel value) {
    if (value == null) {
      return null;
    }
    return json.encode(value.toJson());
  }
}

class MarkColorModelListConverter extends TypeConverter<List<MarkColorModel>, String> {
  const MarkColorModelListConverter();

  @override
  List<MarkColorModel> mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    assert(StringListConverter().mapToDart(fromDb).map((e) => MarkColorModelConverter().mapToDart(e)).isNotEmpty);
    return StringListConverter().mapToDart(fromDb).map((e) => MarkColorModelConverter().mapToDart(e));
  }

  @override
  String mapToSql(List<MarkColorModel> value) {
    assert(value.isNotEmpty);
    if (value == null) {
      return null;
    }
    return StringListConverter().mapToSql(value.map((e) => MarkColorModelConverter().mapToSql(e)));
  }
}
