import 'package:scriny/src/functions/function.dart';

/// A class that allows to accept an object based on its type.
sealed class TypeAcceptor {
  /// Creates a new type acceptor instance.
  const TypeAcceptor();

  /// Whether this type acceptor accepts the given [object].
  bool accept(Object? object);
}

/// Represents a type acceptor that accepts all types.
class AllTypesAcceptor extends TypeAcceptor {
  /// Creates a new all types acceptor onstance.
  const AllTypesAcceptor();

  @override
  bool accept(Object? object) => true;
}

/// Represents a type acceptor that accepts any of the given types.
class MultipleTypesAcceptor extends TypeAcceptor {
  /// The delegates of this acceptor.
  final List<TypeAcceptor> types;

  /// Creates a new multiple type acceptor instance.
  const MultipleTypesAcceptor({
    required this.types,
  });

  @override
  bool accept(Object? object) => types.any((type) => type.accept(object));

  @override
  String toString() => types.join(', ');
}

/// Represents a type acceptor that accepts only [T]s.
class _TypedTypeAcceptor<T> extends TypeAcceptor {
  /// Creates a new typed type acceptor instance.
  const _TypedTypeAcceptor();

  @override
  bool accept(Object? object) => object is T;
}

/// Represents a type acceptor that accepts only [bool]s.
class BooleanTypeAcceptor extends _TypedTypeAcceptor<bool> {
  /// Creates a new boolean type acceptor instance.
  const BooleanTypeAcceptor();
}

/// Represents a type acceptor that accepts only [String]s.
class StringTypeAcceptor extends _TypedTypeAcceptor<String> {
  /// Creates a new string type acceptor instance.
  const StringTypeAcceptor();
}

/// Represents a type acceptor that accepts only [num]s.
class NumberTypeAcceptor extends _TypedTypeAcceptor<num> {
  /// Creates a new number type acceptor instance.
  const NumberTypeAcceptor();
}

/// Represents a type acceptor that accepts only [int]s.
class IntTypeAcceptor extends _TypedTypeAcceptor<int> {
  /// Creates a new int type acceptor instance.
  const IntTypeAcceptor();
}

/// Represents a type acceptor that accepts only [List]s.
class ListTypeAcceptor<T> extends _TypedTypeAcceptor<List<T>> {
  /// Creates a new list type acceptor instance.
  const ListTypeAcceptor();

  @override
  bool accept(Object? object) {
    if (object is List) {
      return object.every((element) => element is T);
    }
    return object is List<T>;
  }
}

/// Represents a type acceptor that accepts only [Map]s.
class MapTypeAcceptor<K, V> extends _TypedTypeAcceptor<Map<K, V>> {
  /// Creates a new map type acceptor instance.
  const MapTypeAcceptor();

  @override
  bool accept(Object? object) {
    if (object is Map) {
      return object.keys.every((key) => key is K && object[key] is V);
    }
    return object is Map<K, V>;
  }
}

/// Represents a type acceptor that accepts only null values.
class NullTypeAcceptor extends TypeAcceptor {
  /// Creates a new null type acceptor instance.
  const NullTypeAcceptor();

  @override
  bool accept(Object? object) => object == null;
}

/// Represents a type acceptor that accepts only [EvaluableFunction]s.
class EvaluableFunctionTypeAcceptor extends _TypedTypeAcceptor<EvaluableFunction> {
  /// Creates a new evaluable function type acceptor instance.
  const EvaluableFunctionTypeAcceptor();
}

