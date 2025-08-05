import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/unaries/unary.dart';

/// Allows takes the opposite sign of a number expression.
class MinusExpression extends UnaryExpression {
  /// The minus symbol.
  static const String minus = '-';

  /// Creates a new minus expression instance.
  const MinusExpression({
    required super.operand,
  }) : super(
         operator: minus,
       );

  @override
  num evaluate(EvaluationContext evaluationContext) {
    Object? operandValue = operand.evaluate(evaluationContext);
    if (operandValue is! num) {
      throw ArgumentError('Cannot do minus on a non-numeric value.');
    }
    return -operandValue;
  }
}
