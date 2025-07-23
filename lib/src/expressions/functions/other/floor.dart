import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the floor function.
class FloorFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates floor function instance.
  const FloorFunction()
    : super(
        identifier: 'floor',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => (arguments.first as num).floor();
}
