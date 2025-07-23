import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/operations/multiplication.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents an integer division expression.
class IntegerDivisionExpression extends BinaryExpression {
  /// The quotient symbol.
  static const String quotient = '~/';

  /// Creates a new integer division expression instance.
  const IntegerDivisionExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: quotient,
       );

  @override
  int get precedence => MultiplicationExpression.multiplicationPrecedence;

  @override
  num evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! num || rightValue is! num) {
      throw ArgumentError('Cannot divide non-numeric values.');
    }
    return leftValue ~/ rightValue;
  }
}
