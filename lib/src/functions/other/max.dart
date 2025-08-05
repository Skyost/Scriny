import 'package:scriny/src/functions/function.dart';
import 'package:scriny/src/utils/type_acceptor.dart';

/// Represents the max function.
class MaxFunction extends EvaluableFunction {
  /// Creates a max function instance.
  const MaxFunction()
    : super(
        identifier: 'max',
      );

  @override
  List<TypeAcceptor> buildTypeAcceptorList(int argumentCount) => List.generate(argumentCount, (_) => const NumberTypeAcceptor());

  @override
  num? run(List<Object?> arguments) {
    num? value;
    for (Object? argument in arguments) {
      if (value == null || (argument as num).compareTo(value) > 0) {
        value = argument as num;
      }
    }
    return value;
  }
}
