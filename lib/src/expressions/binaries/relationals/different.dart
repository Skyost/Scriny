import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/relationals/equal.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents a different (not equal) expression.
/// Note: This performs inequality on evaluated values, which can be numbers, strings, booleans, etc.
class DifferentExpression extends BinaryExpression {
  /// The different symbol.
  static const String different = '!=';

  /// Creates a new different expression instance.
  const DifferentExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: different,
       );

  @override
  int get precedence => EqualExpression.equalPrecedence;

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    return leftValue != rightValue;
  }
}
