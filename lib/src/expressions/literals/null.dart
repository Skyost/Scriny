import 'package:scriny/src/expressions/literals/literal.dart';

/// An expression that represents a null value.
class NullLiteral extends Literal<Null> {
  /// The keyword used to represent a null value.
  static const String keyword = 'null';

  /// Creates a new null literal instance.
  const NullLiteral()
    : super(
        value: null,
      );
}
