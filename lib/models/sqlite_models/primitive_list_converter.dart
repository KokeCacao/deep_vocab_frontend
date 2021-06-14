import 'dart:convert';
import 'package:moor/moor.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String>? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    // see: https://github.com/flutter/flutter/issues/18979
    assert((json.decode(fromDb).cast<String>()).isNotEmpty);
    return json.decode(fromDb).cast<String>();
  }

  @override
  String? mapToSql(List<String?>? value) {
    assert(value!.isNotEmpty);
    if (value == null) {
      return null;
    }
    return json.encode(value);
  }
}

class IntegerListConverter extends TypeConverter<List<int>, String> {
  const IntegerListConverter();

  @override
  List<int>? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }
    // see: https://github.com/flutter/flutter/issues/18979
    assert((json.decode(fromDb).cast<int>()).isNotEmpty);
    return json.decode(fromDb).cast<int>();
  }

  @override
  String? mapToSql(List<int>? value) {
    assert(value!.isNotEmpty);
    if (value == null) {
      return null;
    }
    return json.encode(value);
  }
}
