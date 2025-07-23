import 'dart:math' as math;

import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the arc tangent function.
class ATanFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates a arc tangent function instance.
  const ATanFunction()
    : super(
        identifier: 'atan',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => math.atan(arguments.first as num);
}
