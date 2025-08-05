import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';

/// An expression that is surrounded by parenthesis.
class GroupingExpression extends Expression {
  /// The child expression.
  final Expression operand;

  /// Creates a new grouping expression instance.
  const GroupingExpression({
    required this.operand,
  });

  @override
  Object? evaluate(EvaluationContext evaluationContext) => operand.evaluate(evaluationContext);

  @override
  bool operator ==(Object other) {
    if (other is! GroupingExpression) {
      return super == other;
    }
    return identical(this, other) || operand == other.operand;
  }

  @override
  int get hashCode => operand.hashCode;
}
