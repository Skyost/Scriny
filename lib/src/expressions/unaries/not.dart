import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/unaries/minus.dart';
import 'package:scriny/src/expressions/unaries/unary.dart';

/// Allows takes the opposite value of a boolean expression.
class NotExpression extends UnaryExpression {
  /// The not symbol.
  static const String not = '!';

  /// Creates a new not expression instance.
  const NotExpression({
    required super.operand,
  }) : super(
         operator: not,
       );

  @override
  int get precedence => MinusExpression.unaryMinusPrecedence;

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? operandValue = operand.evaluate(evaluationContext);
    if (operandValue is! bool) {
      throw ArgumentError('Cannot negate a non-boolean value.');
    }
    return !operandValue;
  }
}
