import 'dart:convert';
import 'package:moor_flutter/moor_flutter.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    assert((json.decode(fromDb) as List<String>).isNotEmpty);
    return json.decode(fromDb) as List<String>;
  }

  @override
  String mapToSql(List<String> value) {
    assert(value.isNotEmpty);
    if (value == null) {
      return null;
    }
    return json.encode(value);
  }
}

class IntegerListConverter extends TypeConverter<List<int>, String> {
  const IntegerListConverter();

  @override
  List<int> mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    assert((json.decode(fromDb) as List<int>).isNotEmpty);
    return json.decode(fromDb) as List<int>;
  }

  @override
  String mapToSql(List<int> value) {
    assert(value.isNotEmpty);
    if (value == null) {
      return null;
    }
    return json.encode(value);
  }
}
