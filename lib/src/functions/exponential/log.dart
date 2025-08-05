import 'dart:math' as math;

import 'package:scriny/src/functions/function.dart';

/// Represents the natural logarithm function.
class LogFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates a natural logarithm function instance.
  const LogFunction()
    : super(
        identifier: 'log',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => math.log(arguments.first as num);
}
