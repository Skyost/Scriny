import 'dart:math' as math;

import 'package:scriny/src/functions/function.dart';

/// Represents the arc cosine function.
class ACosFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates a arc cosine function instance.
  const ACosFunction()
    : super(
        identifier: 'acos',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => math.acos(arguments.first as num);
}
