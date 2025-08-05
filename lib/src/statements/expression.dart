import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/expressions/literals/null.dart';
import 'package:scriny/src/statements/statement.dart';

/// A statement that evaluates an expression.
class ExpressionStatement extends Statement {
  /// The expression.
  final Expression expression;

  /// Creates a new expression statement instance.
  const ExpressionStatement({
    this.expression = const NullLiteral(),
  });

  @override
  RunResult? run(EvaluationContext evaluationContext) {
    expression.evaluate(evaluationContext);
    return null;
  }

  @override
  bool operator ==(Object other) {
    if (other is! ExpressionStatement) {
      return super == other;
    }
    return identical(this, other) || expression == other.expression;
  }

  @override
  int get hashCode => expression.hashCode;
}
