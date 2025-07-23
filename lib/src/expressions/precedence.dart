import 'package:scriny/src/expressions/expression.dart';

/// An expression that has a priority.
mixin HasPrecedence on Expression {
  /// The priority of the expression.
  /// Mainly used for [toString] implementations.
  int get precedence => 0;
}
