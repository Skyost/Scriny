import 'package:scriny/src/exceptions/argument_count.dart';
import 'package:scriny/src/exceptions/function_argument_type.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/utils/type_acceptor.dart';

/// Represents an evaluable function.
abstract class EvaluableFunction {
  /// The function identifier.
  final String identifier;

  /// Creates a new function.
  const EvaluableFunction({
    required this.identifier,
  });

  /// The minimum number of arguments.
  int get minimumArguments => 0;

  /// The maximum number of arguments.
  int? get maximumArguments => null;

  /// The accepted argument types.
  List<TypeAcceptor> buildTypeAcceptorList(int argumentCount) => const [];

  /// Evaluates the current function.
  Object? evaluateAndRun(
    List<Expression> arguments,
    EvaluationContext evaluationContext,
  ) {
    if (arguments.length < minimumArguments || (maximumArguments != null && arguments.length > maximumArguments!)) {
      throw WrongArgumentCountException(
        minimumArguments,
        maximumArguments,
        arguments.length,
      );
    }
    List<TypeAcceptor> acceptedArgumentsTypes = buildTypeAcceptorList(
      arguments.length,
    );
    List<Object?> evaluatedArguments = [];
    for (int i = 0; i < arguments.length; i++) {
      Object? evaluationResult = arguments[i].evaluate(evaluationContext);
      TypeAcceptor? typeAcceptor = i >= acceptedArgumentsTypes.length ? null : acceptedArgumentsTypes[i];
      if (typeAcceptor != null && !typeAcceptor.accept(evaluationResult)) {
        throw FunctionArgumentTypeException(
          typeAcceptor,
          evaluationResult.runtimeType,
        );
      }
      evaluatedArguments.add(evaluationResult);
    }
    return run(evaluatedArguments);
  }

  /// Runs the current function with the evaluated arguments.
  Object? run(List<Object?> arguments);
}

/// Represents a function that accepts a fixed number of arguments.
mixin FixedArgumentCount on EvaluableFunction {
  /// The number of arguments.
  int get argumentCount;

  /// The accepted argument types.
  List<TypeAcceptor> get argumentsTypes => List.generate(
    argumentCount,
    (_) => const NumberTypeAcceptor(),
    growable: false,
  );

  @override
  int get minimumArguments => argumentCount;

  @override
  int? get maximumArguments => argumentCount;

  @override
  List<TypeAcceptor> buildTypeAcceptorList(int argumentCount) => argumentsTypes;
}
