import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/relationals/group.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents an inferior or equal expression.
class InferiorOrEqualExpression extends BinaryExpression with InRelationalGroup {
  /// The inferior or equal symbol.
  static const String inferiorOrEqual = '<=';

  /// Creates a new inferior or equal expression instance.
  const InferiorOrEqualExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: inferiorOrEqual,
       );

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! num || rightValue is! num) {
      throw ArgumentError('Cannot check if $left is inferior or equal than $right.');
    }
    return leftValue <= rightValue;
  }
}
