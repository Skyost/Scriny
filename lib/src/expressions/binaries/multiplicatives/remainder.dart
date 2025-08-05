import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/multiplicatives/group.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents a remainder expression.
class RemainderExpression extends BinaryExpression with InMultiplicativeGroup {
  /// The modulus symbol.
  static const String modulus = '%';

  /// Creates a new modulus expression instance.
  const RemainderExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: modulus,
       );

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
