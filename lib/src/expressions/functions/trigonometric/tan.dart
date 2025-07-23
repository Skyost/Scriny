import 'dart:math' as math;

import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the tangent function.
class TanFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates a tangent function instance.
  const TanFunction()
    : super(
        identifier: 'tan',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => math.tan(arguments.first as num);
}
