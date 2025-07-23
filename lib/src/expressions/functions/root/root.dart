import 'dart:math' as math;

import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the root function.
class RootFunction extends EvaluableFunction {
  /// Creates a root function instance.
  const RootFunction()
      : super(
          identifier: 'root',
        );

  @override
  int get minimumArguments => 2;

  @override
  int? get maximumArguments => 2;

  @override
  List<FunctionArgumentType> buildArgumentTypesList(int argumentCount) => const [NumberArgumentType(), NumberArgumentType()];

  @override
  num run(List<Object?> arguments) => math.pow(arguments.first as num, 1 / (arguments[1] as num));
}
