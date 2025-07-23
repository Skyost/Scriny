import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the min function.
class MinFunction extends EvaluableFunction {
  /// Creates a min function instance.
  const MinFunction()
    : super(
        identifier: 'min',
      );

  @override
  List<FunctionArgumentType> buildArgumentTypesList(int argumentCount) => List.generate(argumentCount, (_) => NumberArgumentType());

  @override
  num? run(List<Object?> arguments) {
    num? value;
    for (Object? argument in arguments) {
      if (value == null || (argument as num).compareTo(value) < 0) {
        value = argument as num;
      }
    }
    return value;
  }
}
