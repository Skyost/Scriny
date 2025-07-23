import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the length function.
class LengthFunction extends EvaluableFunction with FixedArgumentCount {
  /// Creates a length function instance.
  const LengthFunction()
    : super(
        identifier: 'length',
      );

  @override
  int get argumentCount => 1;

  @override
  List<FunctionArgumentType> get argumentsTypes => const [AllArgumentType()];

  @override
  int? run(List<Object?> arguments) {
    if (arguments.first == null) {
      return null;
    }
    if (arguments.first is List) {
      return (arguments.first as List).length;
    }
    if (arguments.first is Map) {
      return (arguments.first as Map).length;
    }
    return arguments.first.toString().length;
  }
}
