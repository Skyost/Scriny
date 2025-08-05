import 'package:scriny/src/utils/print/print.dart';

/// Prints an exception to the console.
void printException(Object? exception, [StackTrace? stackTrace]) {
  printToConsole(exception ?? 'An error occurred.');
  printToConsole(stackTrace ?? StackTrace.current);
}

/// Checks if two objects are equal.
bool equalsDeep(Object? a, Object? b) {
  if (a is Map && b is Map) {
    return _mapEquals(a, b);
  }
  if (a is List && b is List) {
    return _listEquals(a, b);
  }
  return a == b;
}

/// Compares two maps for element-by-element equality.
/// From `flutter/foundation.dart`.
bool _mapEquals<T, U>(Map<T, U>? a, Map<T, U>? b) {
  if (a == null) {
    return b == null;
  }
  if (b == null || a.length != b.length) {
    return false;
  }
  if (identical(a, b)) {
    return true;
  }
  for (final T key in a.keys) {
    if (!b.containsKey(key) || !equalsDeep(b[key], a[key])) {
      return false;
    }
  }
  return true;
}

/// Compares two lists for element-by-element equality.
/// From `flutter/foundation.dart`.
bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) {
    return b == null;
  }
  if (b == null || a.length != b.length) {
    return false;
  }
  if (identical(a, b)) {
    return true;
  }
  for (int index = 0; index < a.length; index += 1) {
    if (!equalsDeep(a[index], b[index])) {
      return false;
    }
  }
  return true;
}
