import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/functions/function.dart';
import 'package:scriny/src/utils/utils.dart';

/// An expression that calls a function.
class FunctionCallExpression extends Expression {
  /// The callee.
  final Expression callee;

  /// The arguments of the function.
  final List<Expression> arguments;

  /// Creates a new function call expression instance.
  const FunctionCallExpression({
    required this.callee,
    this.arguments = const [],
  });

  @override
  Object? evaluate(EvaluationContext evaluationContext) {
    Object? function = callee.evaluate(evaluationContext);
    if (function is! EvaluableFunction) {
      throw ArgumentError('Evaluation of $callee does not return a function ($function).');
    }
    return function.evaluateAndRun(arguments, evaluationContext);
  }

  @override
  bool operator ==(Object other) {
    if (other is! FunctionCallExpression) {
      return super == other;
    }
    return identical(this, other) || (callee == other.callee && equalsDeep(arguments, other.arguments));
  }

  @override
  int get hashCode => Object.hash(callee, arguments);
}
