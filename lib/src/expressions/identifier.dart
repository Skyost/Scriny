import 'package:scriny/src/exceptions/unknown_identifier.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';

/// An expression that represents a variable.
class IdentifierExpression extends Expression {
  /// The identifier of the variable.
  final String identifier;

  /// Creates a new variable expression instance.
  const IdentifierExpression({
    required this.identifier,
  });

  @override
  Object? evaluate(EvaluationContext evaluationContext) {
    if (!evaluationContext.hasIdentifierValue(identifier)) {
      throw UnknownIdentifierException(identifier);
    }
    return evaluationContext.getIdentifierValue(identifier);
  }

  @override
  bool operator ==(Object other) {
    if (other is! IdentifierExpression) {
      return super == other;
    }
    return identical(this, other) || identifier == other.identifier;
  }

  @override
  int get hashCode => identifier.hashCode;
}
