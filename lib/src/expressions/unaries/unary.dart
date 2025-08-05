import 'package:scriny/src/expressions/expression.dart';

/// An unary expression that takes one operand and one operator.
abstract class UnaryExpression extends Expression {
  /// The operator of the expression.
  final String operator;

  /// The operand of the expression.
  final Expression operand;

  /// Creates a new unary expression instance.
  const UnaryExpression({
    required this.operator,
    required this.operand,
  });

  @override
  bool operator ==(Object other) {
    if (other is! UnaryExpression) {
      return super == other;
    }
    return identical(this, other) || (operator == other.operator && operand == other.operand);
  }

  @override
  int get hashCode => Object.hash(operator, operand);
}
