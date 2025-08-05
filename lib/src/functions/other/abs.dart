import 'package:scriny/src/functions/function.dart';

/// Represents the absolute value function.
class AbsFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates an absolute value function instance.
  const AbsFunction()
    : super(
        identifier: 'abs',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => (arguments.first as num).abs();
}
