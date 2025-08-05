import 'dart:math' as math;

import 'package:scriny/src/functions/function.dart';

/// Represents the cosine function.
class CosFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates a cosine function instance.
  const CosFunction()
    : super(
        identifier: 'cos',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => math.cos(arguments.first as num);
}
