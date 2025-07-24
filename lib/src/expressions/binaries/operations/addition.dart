import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents an addition expression.
class AdditionExpression extends AssociativeBinaryExpression {
  /// The plus symbol.
  static const String plus = '+';

  /// The addition precedence.
  static const int additionPrecedence = 5;

  /// Creates a new addition expression instance.
  const AdditionExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: plus,
       );

  @override
  int get precedence => additionPrecedence;

  @override
  Object evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is String? || rightValue is String?) {
      return leftValue.toString() + rightValue.toString();
    }
    if (leftValue is num && rightValue is num) {
      return leftValue + rightValue;
    }
    if (leftValue is List && rightValue is List) {
      return leftValue + rightValue;
    }
    if (leftValue is Map && rightValue is Map) {
      return {...leftValue, ...rightValue};
    }
    throw ArgumentError('Cannot add these values : $leftValue and $rightValue.');
  }
}
