import 'dart:math' as math;

import 'package:scriny/src/expressions/functions/function.dart';
import 'package:scriny/src/utils/type_acceptor.dart';

/// Represents the squared root function.
class SqrtFunction extends EvaluableFunction {
  /// Creates a squared root function instance.
  const SqrtFunction()
    : super(
        identifier: 'sqrt',
      );

  @override
  int get minimumArguments => 1;

  @override
  int? get maximumArguments => 1;

  @override
  List<TypeAcceptor> buildTypeAcceptorList(int argumentCount) => const [
    NumberTypeAcceptor(),
  ];

  @override
  num run(List<Object?> arguments) => math.sqrt(arguments.first as num);
}
