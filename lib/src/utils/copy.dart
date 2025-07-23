/// Does a deep copy of a list.
List<T> copyList<T>(List list) {
  List<T> copy = [];

  for (T item in list) {
    if (item is Map) {
      copy.add(copyMap(item) as T);
    } else if (item is List) {
      copy.add(copyList(item) as T);
    } else if (item is Set) {
      copy.add(copySet(item) as T);
    } else {
      copy.add(item);
    }
  }
  return copy;
}

/// Does a deep copy of a map.
Map<K, V> copyMap<K, V>(Map<K, V> map) {
  Map<K, V> copy = {};

  for (MapEntry<K, V> entry in map.entries) {
    K key = entry.key;
    V value = entry.value;
    if (value is Map) {
      copy[key] = copyMap(value) as V;
    } else if (value is List) {
      copy[key] = copyList(value) as V;
    } else if (value is Set) {
      copy[key] = copySet(value) as V;
    } else {
      copy[key] = value;
    }
  }
  return copy;
}

/// Does a deep copy of a set.
Set<T> copySet<T>(Set<T> set) {
  Set<T> copy = {};

  for (T item in set) {
    if (item is Map) {
      copy.add(copyMap(item) as T);
    } else if (item is List) {
      copy.add(copyList(item) as T);
    } else if (item is Set) {
      copy.add(copySet(item) as T);
    } else {
      copy.add(item);
    }
  }
  return copy;
}

/// Allows to do deep copies of a list.
extension ListCopy<T> on List<T> {
  /// Does a deep copy of a list.
  List<T> copy() => copyList<T>(this);
}

/// Allows to do deep copies of a set.
extension SetCopy<T> on Set<T> {
  /// Does a deep copy of a set.
  Set<T> copy() => copySet<T>(this);
}

/// Allows to do deep copies of a map.
extension MapCopy<K, V> on Map<K, V> {
  /// Does a deep copy of a map.
  Map<K, V> copy() => copyMap<K, V>(this);
}
