import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents a multiplication expression.
class MultiplicationExpression extends AssociativeBinaryExpression {
  /// The times symbol.
  static const String times = '*';

  /// The multiplication precedence.
  static const int multiplicationPrecedence = 6;

  /// Creates a new multiplication expression instance.
  const MultiplicationExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: times,
       );

  @override
  int get precedence => multiplicationPrecedence;

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
