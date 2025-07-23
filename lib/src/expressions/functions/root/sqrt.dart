import 'dart:math' as math;

import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the squared root function.
class SqrtFunction extends EvaluableFunction {
  /// Creates a squared root function instance.
  const SqrtFunction()
      : super(
          identifier: 'sqrt',
        );

  @override
  int get minimumArguments => 1;

  @override
  int? get maximumArguments => 1;

  @override
  List<FunctionArgumentType> buildArgumentTypesList(int argumentCount) => const [NumberArgumentType()];

  @override
  num run(List<Object?> arguments) => math.sqrt(arguments.first as num);
}
