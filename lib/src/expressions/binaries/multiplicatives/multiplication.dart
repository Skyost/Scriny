import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/multiplicatives/group.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents a multiplication expression.
class MultiplicationExpression extends BinaryExpression with InMultiplicativeGroup {
  /// The times symbol.
  static const String times = '*';

  /// Creates a new multiplication expression instance.
  const MultiplicationExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: times,
       );

  @override
  num evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! num || rightValue is! num) {
      throw ArgumentError('Cannot multiply non-numeric values.');
    }
    return leftValue * rightValue;
  }
}
