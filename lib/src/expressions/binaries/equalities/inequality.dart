import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/equalities/group.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/utils/utils.dart';

/// Represents a different (not equal) expression.
/// Note: This performs inequality on evaluated values, which can be numbers, strings, booleans, etc.
class InequalityExpression extends BinaryExpression with InEqualityGroup {
  /// The different symbol.
  static const String different = '!=';

  /// Creates a new different expression instance.
  const InequalityExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: different,
       );

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    return !equalsDeep(leftValue, rightValue);
  }
}
