import 'package:scriny/src/exceptions/unknown_identifier.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';

/// An expression that represents a collection access.
class CollectionAccessExpression extends Expression {
  /// The identifier of the collection.
  final String identifier;

  /// The value to access.
  final Expression key;

  /// Creates a new collection access expression instance.
  const CollectionAccessExpression({
    required this.identifier,
    required this.key,
  });

  @override
  Object evaluate(EvaluationContext evaluationContext) {
    Object? evaluatedKey = key.evaluate(evaluationContext);
    Object? collection = evaluationContext.getVariableValue(identifier);
    if (collection == null) {
      throw UnknownIdentifierException(identifier);
    }
    if (collection is List) {
      if (evaluatedKey is! int) {
        throw ArgumentError('Key must be an integer.');
      }
      return collection[evaluatedKey];
    }
    if (collection is String) {
      if (evaluatedKey is! int) {
        throw ArgumentError('Key must be an integer.');
      }
      return collection[evaluatedKey];
    }
    if (collection is Map) {
      return collection[evaluatedKey];
    }
    throw ArgumentError('[] must be used on a string, a list or a map.');
  }

  @override
  String toString() => '$identifier[$key]';

  @override
  bool operator ==(Object other) {
    if (other is! CollectionAccessExpression) {
      return super == other;
    }
    return identical(this, other) || (identifier == other.identifier && key == other.key);
  }

  @override
  int get hashCode => Object.hash(identifier, key);
}
