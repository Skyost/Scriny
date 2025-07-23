import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/operations/multiplication.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents a modulus expression.
class ModulusExpression extends BinaryExpression {
  /// The modulus symbol.
  static const String modulus = '%';

  /// Creates a new modulus expression instance.
  const ModulusExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: modulus,
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
    return leftValue % rightValue;
  }
}
