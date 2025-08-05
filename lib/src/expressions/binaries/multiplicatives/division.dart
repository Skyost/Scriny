import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/multiplicatives/group.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents a division expression.
class DivisionExpression extends BinaryExpression with InMultiplicativeGroup {
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
  num evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! num || rightValue is! num) {
      throw ArgumentError('Cannot divide non-numeric values.');
    }
    return leftValue / rightValue;
  }
}
