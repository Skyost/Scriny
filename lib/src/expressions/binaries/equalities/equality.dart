import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/equalities/group.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/utils/utils.dart';

/// Represents an equal expression.
/// Note: This performs equality on evaluated values, which can be numbers, strings, booleans, etc.
class EqualityExpression extends BinaryExpression with InEqualityGroup {
  /// The equal symbol.
  static const String equal = '==';

  /// Creates a new equal expression instance.
  const EqualityExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: equal,
       );

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    return equalsDeep(leftValue, rightValue);
  }
}
