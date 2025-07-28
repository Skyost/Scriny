import 'package:scriny/src/exceptions/unknown_identifier.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/expressions/functions/function.dart';
import 'package:scriny/src/utils/utils.dart';

/// An expression that calls a function.
class FunctionCallExpression extends Expression {
  /// The identifier of the function.
  final String identifier;

  /// The arguments of the function.
  final List<Expression> arguments;

  /// Creates a new function call expression instance.
  const FunctionCallExpression({
    required this.identifier,
    this.arguments = const [],
  });

  @override
  Object? evaluate(EvaluationContext evaluationContext) {
    EvaluableFunction? function = evaluationContext.getFunctionByIdentifier(
      identifier,
    );
    if (function == null) {
      throw UnknownIdentifierException(identifier);
    }
    return function.evaluateAndRun(arguments, evaluationContext);
  }

  @override
  String toString() => '$identifier(${arguments.join(', ')})';

  @override
  bool operator ==(Object other) {
    if (other is! FunctionCallExpression) {
      return super == other;
    }
    return identical(this, other) || (identifier == other.identifier && listEquals(arguments, other.arguments));
  }

  @override
  int get hashCode => Object.hash(identifier, arguments);
}
