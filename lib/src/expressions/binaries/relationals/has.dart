import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/binaries/relationals/group.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';

/// Represents a has expression. Allows to test whether a collection contains a value.
class HasExpression extends BinaryExpression with InRelationalGroup {
  /// The has symbol.
  static const String has = 'has';

  /// Creates a new has expression instance.
  const HasExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: has,
       );

  @override
  bool evaluate(EvaluationContext evaluationContext) {
    Object? leftValue = left.evaluate(evaluationContext);
    Object? rightValue = right.evaluate(evaluationContext);
    if (leftValue is List) {
      return leftValue.contains(rightValue);
    }
    if (leftValue is Map) {
      return leftValue.containsKey(rightValue);
    }
    if (leftValue is String) {
      return leftValue.contains(rightValue.toString());
    }
    throw ArgumentError('$has is not supported for $leftValue.');
  }
}
