import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents an equal expression.
/// Note: This performs equality on evaluated values, which can be numbers, strings, booleans, etc.
class EqualExpression extends BinaryExpression {
  /// The equal symbol.
  static const String equal = '==';

  /// The equal precedence.
  static const int equalPrecedence = 4;

  /// Creates a new equal expression instance.
  const EqualExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: equal,
       );

  @override
  int get precedence => equalPrecedence;

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    return leftValue == rightValue;
  }
}
