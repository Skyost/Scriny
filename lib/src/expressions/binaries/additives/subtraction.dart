import 'package:scriny/src/expressions/binaries/additives/group.dart';
import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents an subtraction expression.
class SubtractionExpression extends BinaryExpression with InAdditiveGroup {
  /// The minus symbol.
  static const String minus = '-';

  /// Creates a new subtraction expression instance.
  const SubtractionExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: minus,
       );

  @override
  Object evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! num || rightValue is! num) {
      throw ArgumentError('Cannot subtract non-numeric values.');
    }
    return leftValue - rightValue;
  }
}
