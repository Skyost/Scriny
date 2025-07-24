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

  @override
  String toString() {
    String leftString = left.toString();
    String rightString = right.toString();

    if (_shouldParenthesize(left, isLeft: true)) {
      leftString = '($leftString)';
    }

    if (_shouldParenthesize(right, isLeft: false)) {
      rightString = '($rightString)';
    }

    return '$leftString $operator $rightString';
  }

  /// Returns `true` if the child should be parenthesized in the [toString] representation.
  bool _shouldParenthesize(Expression child, {required bool isLeft}) => child is HasPrecedence && child.precedence < precedence;

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

/// A class for binary expressions that can be mathematically left-associative or right-associative.
abstract class AssociativeBinaryExpression extends BinaryExpression {
  /// Creates a new associative binary expression instance.
  const AssociativeBinaryExpression({
    required super.left,
    required super.operator,
    required super.right,
  });

  /// Returns `true` if the operator is mathematically left-associative.
  bool get isMathematicallyLeftAssociative => true;

  /// Returns `true` if the operator is mathematically right-associative.
  bool get isMathematicallyRightAssociative => true;

  @override
  String toString() {
    String leftString = left.toString();
    String rightString = right.toString();

    if (_shouldParenthesize(left, isLeft: true)) {
      leftString = '($leftString)';
    }

    if (_shouldParenthesize(right, isLeft: false)) {
      rightString = '($rightString)';
    }

    return '$leftString $operator $rightString';
  }

  @override
  bool _shouldParenthesize(Expression child, {required bool isLeft}) {
    if (child is HasPrecedence) {
      if (child.precedence < precedence) {
        return true;
      }

      if (child.precedence > precedence) {
        return false;
      }

      if (isLeft && !isMathematicallyLeftAssociative) {
        return true;
      }
      if (!isLeft && !isMathematicallyRightAssociative) {
        return true;
      }
    }

    return false;
  }
}
