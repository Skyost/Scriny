import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/expressions/literals/null.dart';
import 'package:scriny/src/statements/statement.dart';

/// A statement that assigns a value to a variable.
class AssignStatement extends Statement {
  /// The character used to define a variable.
  static const String define = '=';

  /// The identifier of the variable.
  final String identifier;

  /// The value of the variable.
  final Expression value;

  /// Creates a new assign statement instance.
  const AssignStatement({
    required this.identifier,
    this.value = const NullLiteral(),
  });

  @override
  RunResult? run(EvaluationContext evaluationContext) {
    Object? value = this.value.evaluate(evaluationContext);
    evaluationContext.setVariableValue(identifier, value);
    return null;
  }

  @override
  String toString() => '$identifier $define $value;';

  @override
  bool operator ==(Object other) {
    if (other is! AssignStatement) {
      return super == other;
    }
    return identical(this, other) || (identifier == other.identifier && value == other.value);
  }

  @override
  int get hashCode => Object.hash(identifier, value);
}
