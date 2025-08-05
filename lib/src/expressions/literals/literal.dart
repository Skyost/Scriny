import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';

/// An expression that represents a literal value.
class Literal<T extends Object?> extends Expression {
  /// The value of the literal.
  final T value;

  /// Creates a new literal instance.
  const Literal({
    required this.value,
  });

  @override
  T evaluate(EvaluationContext evaluationContext) => value;

  @override
  bool operator ==(Object other) {
    if (other is! Literal) {
      return super == other;
    }
    return identical(this, other) || value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}
