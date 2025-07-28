import 'package:scriny/src/exceptions/unknown_identifier.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/statements/assign/identifier.dart';
import 'package:scriny/src/statements/statement.dart';

/// A statement that assigns a value to a collection at a given index.
class CollectionIndexAssignStatement extends AssignStatement {
  /// The index of the value.
  final Expression index;

  /// Creates a new collection index assign statement instance.
  const CollectionIndexAssignStatement({
    required super.identifier,
    super.value,
    required this.index,
  });

  @override
  RunResult? run(EvaluationContext evaluationContext) {
    Object? collection = evaluationContext.getVariableValue(identifier);
    if (collection == null) {
      throw UnknownIdentifierException(identifier);
    }
    Object? evaluatedIndex = index.evaluate(evaluationContext);
    Object? evaluatedValue = value.evaluate(evaluationContext);
    if (collection is String) {
      if (evaluatedIndex is! int) {
        throw ArgumentError('Index must be an integer.');
      }
      collection = collection.replaceRange(
        evaluatedIndex,
        evaluatedIndex + 1,
        evaluatedValue.toString(),
      );
      evaluationContext.setVariableValue(identifier, collection);
      return null;
    }
    if (collection is List) {
      if (evaluatedIndex is! int) {
        throw ArgumentError('Index must be an integer.');
      }
      collection[evaluatedIndex] = evaluatedValue;
      evaluationContext.setVariableValue(identifier, collection);
      return null;
    }
    if (collection is Map) {
      collection[evaluatedIndex] = evaluatedValue;
      evaluationContext.setVariableValue(identifier, collection);
      return null;
    }
    throw ArgumentError('Assignment with [] must be used on a string, a list or a map.');
  }

  @override
  String toString() => '$identifier[$index] ${AssignStatement.define} $value;';

  @override
  bool operator ==(Object other) {
    if (other is! CollectionIndexAssignStatement) {
      return super == other;
    }
    return identical(this, other) || (identifier == other.identifier && value == other.value && index == other.index);
  }

  @override
  int get hashCode => Object.hash(identifier, value, index);
}
