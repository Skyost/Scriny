import 'package:scriny/src/functions/function.dart';
import 'package:scriny/src/utils/type_acceptor.dart';

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
  List<TypeAcceptor> get argumentsTypes => const [AllTypesAcceptor()];

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
