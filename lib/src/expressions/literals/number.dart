import 'package:scriny/src/expressions/literals/literal.dart';

/// An expression that represents a number.
class NumberLiteral extends Literal<num> {
  /// Creates a new number literal instance.
  const NumberLiteral({
    required super.value,
  });

  /// Creates a new number literal instance from a string.
  NumberLiteral.parse(String value)
    : this(
        value: num.parse(value),
      );
}
