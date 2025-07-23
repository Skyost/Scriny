import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/relationals/equal.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents an inferior expression.
class InferiorExpression extends BinaryExpression {
  /// The inferior symbol.
  static const String inferior = '<';

  /// Creates a new inferior expression instance.
  const InferiorExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: inferior,
       );

  @override
  int get precedence => EqualExpression.equalPrecedence;

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! num || rightValue is! num) {
      throw ArgumentError('Cannot check if $left is inferior than $right.');
    }
    return leftValue < rightValue;
  }
}
