import 'dart:math' as math;

import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the exponential function.
class ExpFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates an exponential function instance.
  const ExpFunction()
    : super(
        identifier: 'exp',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => math.exp(arguments.first as num);
}
