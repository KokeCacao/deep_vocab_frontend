import 'package:collection/collection.dart' show IterableExtension;

class Util {
  static String enumToString(o) => o.toString().split('.').last;

  static T? enumFromString<T>(Iterable<T> values, String value) {
    return values.firstWhereOrNull((type) => type.toString().split('.').last == value);
  }
}