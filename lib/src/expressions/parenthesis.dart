import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/expressions/precedence.dart';

/// An expression that is surrounded by parenthesis.
class ParenthesisExpression extends Expression with HasPrecedence {
  /// The child expression.
  final Expression expression;

  /// The parenthesis precedence.
  static const int parenthesisPrecedence = -1 >>> 1;

  /// Creates a new parenthesis expression instance.
  const ParenthesisExpression({
    required this.expression,
  });

  @override
  int get precedence => parenthesisPrecedence;

  @override
  Object? evaluate(EvaluationContext evaluationContext) => expression.evaluate(evaluationContext);

  @override
  String toString() => '($expression)';

  @override
  bool operator ==(Object other) {
    if (other is! ParenthesisExpression) {
      return super == other;
    }
    return identical(this, other) || expression == other.expression;
  }

  @override
  int get hashCode => expression.hashCode;
}
