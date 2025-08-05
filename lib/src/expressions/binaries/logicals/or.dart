import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/logicals/group.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents an or expression.
class OrExpression extends BinaryExpression with InLogicalGroup {
  /// The or symbol.
  static const String or = '||';

  /// Creates a new or expression instance.
  const OrExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: or,
       );

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
