import 'dart:math' as math;

import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the arc sine function.
class ASinFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates a arc sine function instance.
  const ASinFunction()
    : super(
        identifier: 'asin',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => math.asin(arguments.first as num);
}
