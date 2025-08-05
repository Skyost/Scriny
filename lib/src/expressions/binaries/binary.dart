import 'package:scriny/src/expressions/expression.dart';

/// Represents a binary expression with two operands and an operator.
abstract class BinaryExpression extends Expression {
  /// The left operand.
  final Expression left;

  /// The operator.
  final String operator;

  /// The right operand.
  final Expression right;

  /// Creates a new binary expression instance.
  const BinaryExpression({
    required this.left,
    required this.operator,
    required this.right,
  });

  @override
  bool operator ==(Object other) {
    if (other is! BinaryExpression) {
      return super == other;
    }
    return identical(this, other) || (left == other.left && operator == other.operator && right == other.right);
  }

  @override
  int get hashCode => Object.hash(left, operator, right);
}
