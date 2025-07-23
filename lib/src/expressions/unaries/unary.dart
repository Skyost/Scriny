import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/expressions/precedence.dart';

/// An unary expression that takes one operand and one operator.
abstract class UnaryExpression extends Expression with HasPrecedence {
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
  String toString() {
    String operandString = operand.toString();
    if (operand is HasPrecedence && (operand as HasPrecedence).precedence < precedence) {
      operandString = '($operandString)';
    }
    return '$operator$operandString';
  }

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
