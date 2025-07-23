import 'dart:math' as math;

import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents a power expression.
class PowerExpression extends BinaryExpression {
  /// The power symbol.
  static const String power = '^';

  /// The power precedence.
  static const int powerPrecedence = 7;

  /// Creates a new power expression instance.
  const PowerExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: power,
       );

  @override
  bool get isLeftAssociative => false;

  @override
  int get precedence => powerPrecedence;

  @override
  num evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! num || rightValue is! num) {
      throw ArgumentError('Cannot evaluate power expression with non-numeric values.');
    }
    return math.pow(leftValue, rightValue);
  }
}
