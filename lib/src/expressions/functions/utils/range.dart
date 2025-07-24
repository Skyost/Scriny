import 'package:scriny/src/expressions/functions/function.dart';
import 'package:scriny/src/utils/type_acceptor.dart';

/// Represents the range function.
class RangeFunction extends EvaluableFunction {
  /// Creates a range function instance.
  const RangeFunction()
      : super(
          identifier: 'range',
        );

  @override
  int get minimumArguments => 1;

  @override
  int? get maximumArguments => 3;

  @override
  List<TypeAcceptor> buildTypeAcceptorList(int argumentCount) => [
    NumberTypeAcceptor(),
    if (argumentCount >= 2) NumberTypeAcceptor(),
    if (argumentCount >= 3) NumberTypeAcceptor(),
  ];

  @override
  List<num> run(List<Object?> arguments) {
    num start = arguments.first as num;
    num stop;
    num step = 1;
    if (arguments.length >= 2) {
      stop = arguments[1] as num;
      if (arguments.length >= 3) {
        if (arguments[2] == 0) {
          throw ArgumentError('The third argument cannot be equal to zero.');
        }
        step = arguments[2] as num;
      }
    } else {
      stop = start;
      start = 0;
    }

    List<num> result = [];
    if (step > 0) {
      for (num i = start; i < stop; i += step) {
        result.add(i);
      }
    } else {
      for (num i = start; i > stop; i += step) {
        result.add(i);
      }
    }

    return result;
  }
}
