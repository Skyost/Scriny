import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/expressions/variables/collection_access.dart';
import 'package:scriny/src/expressions/variables/identifier.dart';
import 'package:scriny/src/statements/statement.dart';

/// A statement that unassigns a variable.
class DeleteStatement extends Statement {
  /// The delete keyword.
  static const String keyword = 'delete';

  /// The target expression.
  final Expression expression;

  /// Creates a new delete statement instance.
  const DeleteStatement({
    required this.expression,
  });

  @override
  RunResult? run(EvaluationContext evaluationContext) {
    if (expression is IdentifierExpression) {
      evaluationContext.removeVariable((expression as IdentifierExpression).identifier);
    }
    else if (expression is CollectionAccessExpression) {
      String identifier = (expression as CollectionAccessExpression).identifier;
      Object? collection = evaluationContext.getVariableValue(identifier);
      Object? key = (expression as CollectionAccessExpression).key.evaluate(evaluationContext);
      if (collection is List) {
        if (key is int) {
          collection.removeAt(key);
        } else {
          collection.remove(key);
        }
        evaluationContext.setVariableValue(identifier, collection);
      }
      else if (collection is Map) {
        collection.remove(key);
        evaluationContext.setVariableValue(identifier, collection);
      }
    }
    return null;
  }

  @override
  String toString() => '$keyword $expression;';

  @override
  bool operator ==(Object other) {
    if (other is! DeleteStatement) {
      return super == other;
    }
    return identical(this, other) || expression == other.expression;
  }

  @override
  int get hashCode => expression.hashCode;
}
