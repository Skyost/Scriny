import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/expressions/precedence.dart';

/// Represents a binary expression with two operands and an operator.
abstract class BinaryExpression extends Expression with HasPrecedence {
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

  /// Returns `true` if the operator is right-associative.
  bool get isLeftAssociative => true;

  @override
  String toString() {
    String leftString = left.toString();
    String rightString = right.toString();

    if (left is HasPrecedence) {
      int leftPrecedence = (left as HasPrecedence).precedence;
      if (leftPrecedence < precedence || (leftPrecedence == precedence && isLeftAssociative)) {
        leftString = '($leftString)';
      }
    }

    if (right is HasPrecedence) {
      int rightPrecedence = (right as HasPrecedence).precedence;
      if (rightPrecedence < precedence || (rightPrecedence == precedence && isLeftAssociative)) {
        rightString = '($rightString)';
      }
    }

    return '$leftString $operator $rightString';
  }

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
