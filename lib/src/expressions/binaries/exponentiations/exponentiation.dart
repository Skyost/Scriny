import 'dart:math' as math;

import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/exponentiations/group.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents an exponentiation expression.
class ExponentiationExpression extends BinaryExpression with InExponentiationGroup {
  /// The power symbol.
  static const String power = '^';

  /// Creates a new exponentiation expression instance.
  const ExponentiationExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: power,
       );

  @override
  num evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! num || rightValue is! num) {
      throw ArgumentError('Cannot evaluate exponentiation expression with non-numeric values.');
    }
    return math.pow(leftValue, rightValue);
  }
}
