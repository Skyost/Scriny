import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/ternaries/ternary.dart';

/// Represents a conditional expression.
class ConditionalExpression extends TernaryExpression {
  /// The condition separator.
  static const String conditionSeparator = '?';

  /// The expressions separator.
  static const String expressionsSeparator = ':';

  /// Creates a new addition expression instance.
  const ConditionalExpression({
    required super.first,
    required super.second,
    required super.third,
  }) : super(
         firstSymbol: conditionSeparator,
         secondSymbol: expressionsSeparator,
       );

  @override
  Object? evaluate(EvaluationContext evaluationContext) {
    Object? conditionValue = first.evaluate(evaluationContext);
    if (conditionValue is! bool) {
      throw ArgumentError('Cannot use $conditionSeparator on a non-boolean value.');
    }
    return conditionValue ? second.evaluate(evaluationContext) : third.evaluate(evaluationContext);
  }
}
