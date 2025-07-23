import 'package:scriny/src/expressions/literals/literal.dart';

/// An expression that represents a string.
class StringLiteral extends Literal<String> {
  /// Creates a new string literal instance.
  const StringLiteral({
    required super.value,
  });

  @override
  String toString() => '"$value"';
}
