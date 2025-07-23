import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the ceiling function.
class CeilFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates a ceiling function instance.
  const CeilFunction()
    : super(
        identifier: 'ceil',
      );

  @override
  int get argumentCount => 1;

  @override
  num run(List<Object?> arguments) => (arguments.first as num).ceil();
}
