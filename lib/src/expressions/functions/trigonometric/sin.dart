import 'dart:math' as math;

import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the sine function.
class SinFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates a sine function instance.
  const SinFunction()
    : super(
        identifier: 'sin',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => math.sin(arguments.first as num);
}
