import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/logicals/group.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents an and expression.
class AndExpression extends BinaryExpression with InLogicalGroup {
  /// The and symbol.
  static const String and = '&&';

  /// Creates a new and expression instance.
  const AndExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: and,
       );

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is! bool || rightValue is! bool) {
      throw ArgumentError('Cannot use $and on non-boolean values.');
    }
    return leftValue && rightValue;
  }
}
