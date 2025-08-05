import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/relationals/group.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents a superior expression.
class SuperiorExpression extends BinaryExpression with InRelationalGroup {
  /// The superior symbol.
  static const String superior = '>';

  /// Creates a new superior expression instance.
  const SuperiorExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: superior,
       );

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! num || rightValue is! num) {
      throw ArgumentError('Cannot check if $left is superior than $right.');
    }
    return leftValue > rightValue;
  }
}
