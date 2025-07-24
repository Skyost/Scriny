import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/operations/multiplication.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents a division expression.
class DivisionExpression extends AssociativeBinaryExpression {
  /// The divide symbol.
  static const String divide = '/';

  /// Creates a new division expression instance.
  const DivisionExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: divide,
       );

  @override
  bool get isMathematicallyRightAssociative => false;

  @override
  int get precedence => MultiplicationExpression.multiplicationPrecedence;

  @override
  num evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! num || rightValue is! num) {
      throw ArgumentError('Cannot divide non-numeric values.');
    }
    return leftValue / rightValue;
  }
}
