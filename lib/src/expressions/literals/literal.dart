import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/expressions/precedence.dart';

/// An expression that represents a literal value.
class Literal<T extends Object?> extends Expression with HasPrecedence {
  /// The value of the literal.
  final T value;

  /// The literal precedence.
  static const int literalPrecedence = -1 >>> 1;

  /// Creates a new literal instance.
  const Literal({
    required this.value,
  });

  @override
  int get precedence => literalPrecedence;

  @override
  T evaluate(EvaluationContext evaluationContext) => value;

  @override
  String toString() => '$value';

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
