import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the round function.
class RoundFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates a round function instance.
  const RoundFunction()
    : super(
        identifier: 'round',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => (arguments.first as num).round();
}
