import 'dart:math' as math;

import 'package:scriny/src/expressions/functions/function.dart';
import 'package:scriny/src/utils/type_acceptor.dart';

/// Represents the root function.
class RootFunction extends EvaluableFunction {
  /// Creates a root function instance.
  const RootFunction()
      : super(
          identifier: 'root',
        );

  @override
  int get minimumArguments => 2;

  @override
  int? get maximumArguments => 2;

  @override
  List<TypeAcceptor> buildTypeAcceptorList(int argumentCount) => const [NumberTypeAcceptor(), NumberTypeAcceptor()];

  @override
  num run(List<Object?> arguments) => math.pow(arguments.first as num, 1 / (arguments[1] as num));
}
