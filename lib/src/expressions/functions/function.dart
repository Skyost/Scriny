import 'package:scriny/src/exceptions/argument_count.dart';
import 'package:scriny/src/exceptions/function_argument_type.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';

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
  List<FunctionArgumentType> buildArgumentTypesList(int argumentCount) => const [];

  /// Evaluates the current function.
  Object? evaluateAndRun(List<Expression> arguments, EvaluationContext evaluationContext) {
    if (arguments.length < minimumArguments || (maximumArguments != null && arguments.length > maximumArguments!)) {
      throw WrongArgumentCountException(minimumArguments, maximumArguments, arguments.length);
    }
    List<FunctionArgumentType> acceptedArgumentsTypes = buildArgumentTypesList(arguments.length);
    List<Object?> evaluatedArguments = [];
    for (int i = 0; i < arguments.length; i++) {
      Object? evaluationResult = arguments[i].evaluate(evaluationContext);
      FunctionArgumentType? type = i >= acceptedArgumentsTypes.length ? null : acceptedArgumentsTypes[i];
      if (type != null && !type.accept(evaluationResult)) {
        throw FunctionArgumentTypeException(type, evaluationResult.runtimeType);
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
  List<FunctionArgumentType> get argumentsTypes => List.generate(
    argumentCount,
    (_) => const NumberArgumentType(),
    growable: false,
  );

  @override
  int get minimumArguments => argumentCount;

  @override
  int? get maximumArguments => argumentCount;

  @override
  List<FunctionArgumentType> buildArgumentTypesList(int argumentCount) => argumentsTypes;
}

/// Represents a function argument type.
sealed class FunctionArgumentType {
  /// Creates a new function argument type.
  const FunctionArgumentType();

  /// Whether this argument type accepts the given [object].
  bool accept(Object? object);
}

/// Represents a function argument type that accepts all types.
class AllArgumentType extends FunctionArgumentType {
  /// Creates a new all argument type.
  const AllArgumentType();

  @override
  bool accept(Object? object) => true;
}

/// Represents a function argument type that accepts only one of the given types.
class MultipleArgumentType extends FunctionArgumentType {
  /// The types that this argument type accepts.
  final List<FunctionArgumentType> types;

  /// Creates a new multiple argument type.
  const MultipleArgumentType({
    required this.types,
  });

  @override
  bool accept(Object? object) => types.any((type) => type.accept(object));

  @override
  String toString() => types.join(', ');
}

/// Represents a function argument type that accepts only [T]s.
class _TypedFunctionArgumentType<T> extends FunctionArgumentType {
  /// Creates a new typed argument type.
  const _TypedFunctionArgumentType();

  @override
  bool accept(Object? object) => object is T;
}

/// Represents a function argument type that accepts only [String]s.
class StringArgumentType extends _TypedFunctionArgumentType<String> {
  /// Creates a new string argument type.
  const StringArgumentType();
}

/// Represents a function argument type that accepts only [num]s.
class NumberArgumentType extends _TypedFunctionArgumentType<num> {
  /// Creates a new number argument type.
  const NumberArgumentType();
}

/// Represents a function argument type that accepts only [int]s.
class IntArgumentType extends _TypedFunctionArgumentType<int> {
  /// Creates a new int argument type.
  const IntArgumentType();
}

/// Represents a function argument type that accepts only [List]s.
class ListArgumentType<T> extends _TypedFunctionArgumentType<List<T>> {
  /// Creates a new list argument type.
  const ListArgumentType();

  @override
  bool accept(Object? object) {
    if (object is List) {
      return object.every((element) => element is T);
    }
    return object is List<T>;
  }
}

/// Represents a function argument type that accepts only [Map]s.
class MapArgumentType<K, V> extends _TypedFunctionArgumentType<Map<K, V>> {
  /// Creates a new map argument type.
  const MapArgumentType();

  @override
  bool accept(Object? object) {
    if (object is Map) {
      return object.keys.every((key) => key is K && object[key] is V);
    }
    return object is Map<K, V>;
  }
}

/// Represents a function argument type that accepts only null values.
class NullArgumentType extends FunctionArgumentType {
  /// Creates a new null argument type.
  const NullArgumentType();

  @override
  bool accept(Object? object) => object == null;
}
