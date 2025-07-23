import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/relationals/equal.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents a superior or equal expression.
class SuperiorOrEqualExpression extends BinaryExpression {
  /// The superior or equal symbol.
  static const String superiorOrEqual = '>=';

  /// Creates a new superior or equal expression instance.
  const SuperiorOrEqualExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: superiorOrEqual,
       );

  @override
  int get precedence => EqualExpression.equalPrecedence;

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! num || rightValue is! num) {
      throw ArgumentError('Cannot check if $left is superior or equal than $right.');
    }
    return leftValue >= rightValue;
  }
}
