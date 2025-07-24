import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents an or expression.
class OrExpression extends AssociativeBinaryExpression {
  /// The or symbol.
  static const String or = '||';

  /// The or precedence.
  static const int orPrecedence = 1;

  /// Creates a new or expression instance.
  const OrExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: or,
       );

  @override
  int get precedence => orPrecedence;

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! bool || rightValue is! bool) {
      throw ArgumentError('Cannot use $or on non-boolean values.');
    }
    return leftValue || rightValue;
  }
}
