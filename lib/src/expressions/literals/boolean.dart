import 'package:scriny/src/expressions/literals/literal.dart';

/// An expression that represents a boolean.
class BooleanLiteral extends Literal<bool> {
  /// The keyword used to represent `true`.
  static const String trueKeyword = 'true';

  /// The keyword used to represent `false`.
  static const String falseKeyword = 'false';

  /// Creates a new boolean literal instance.
  const BooleanLiteral({
    required super.value,
  });

  /// Creates a new boolean literal instance from a string.
  const BooleanLiteral.parse(String value)
    : this(
        value: value == trueKeyword,
      );
}
