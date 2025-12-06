import 'package:scriny/scriny.dart';

/// Represents a ternary expression with three operands and an operator.
abstract class TernaryExpression extends Expression {
  /// The first expression.
  final Expression first;

  /// The first symbol.
  final String firstSymbol;

  /// The second expression.
  final Expression second;

  /// The second symbol.
  final String secondSymbol;

  /// The third expression.
  final Expression third;

  /// Creates a new ternary expression instance.
  const TernaryExpression({
    required this.first,
    required this.firstSymbol,
    required this.second,
    required this.secondSymbol,
    required this.third,
  });

  @override
  bool operator ==(Object other) {
    if (other is! TernaryExpression) {
      return super == other;
    }
    return identical(this, other) || (first == other.first && firstSymbol == other.firstSymbol && second == other.second && secondSymbol == other.secondSymbol && third == other.third);
  }

  @override
  int get hashCode => Object.hash(first, firstSymbol, second, secondSymbol, third);
}
