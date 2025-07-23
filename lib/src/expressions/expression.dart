import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/parser.dart';

/// An expression that can be evaluated.
abstract class Expression {
  /// Creates a new expression instance.
  const Expression();

  /// Parses an expression from a string.
  factory Expression.parse(String expression) => ScrinyParser.parseExpression(expression);

  /// Evaluates the value of the current expression.
  Object? evaluate(EvaluationContext evaluationContext);
}
