import 'dart:math' as math;

import 'package:scriny/src/expressions/functions/functions.dart';
import 'package:scriny/src/utils/copy.dart';

/// Allows to hold variables and functions for evaluations.
class EvaluationContext {
  /// The default variables.
  static const Map<String, Object?> defaultVariables = {
    'e': math.e,
    'pi': math.pi,
  };

  /// The default functions.
  static const List<EvaluableFunction> defaultFunctions = [
    ExpFunction(),
    LogFunction(),
    SqrtFunction(),
    RootFunction(),
    AbsFunction(),
    CeilFunction(),
    FloorFunction(),
    RoundFunction(),
    MaxFunction(),
    MinFunction(),
    CosFunction(),
    SinFunction(),
    TanFunction(),
    ACosFunction(),
    ASinFunction(),
    ATanFunction(),
    PrintFunction(),
    LengthFunction(),
    RangeFunction(),
  ];

  /// Evaluator variables.
  final Map<String, Object?> _variables;

  /// Evaluator functions.
  final Map<String, EvaluableFunction> _functions;

  /// Creates a new evaluation context instance.
  EvaluationContext({
    Map<String, Object?> variables = defaultVariables,
    List<EvaluableFunction> functions = defaultFunctions,
  }) : this._(
         variables: Map.of(variables),
         functions: functions.toMap(),
       );

  /// Creates a new evaluation context instance.
  EvaluationContext._({
    required Map<String, Object?> variables,
    required Map<String, EvaluableFunction> functions,
  }) : _variables = variables,
       _functions = functions;

  /// Returns a variable value.
  Object? getVariableValue(String identifier) => _copyObject(_variables[identifier]);

  /// Sets a variable value.
  Object? setVariableValue(String identifier, Object? value) => _variables[identifier] = _copyObject(value);

  /// Checks if the context has the corresponding variable.
  bool hasVariable(String identifier) => _variables.containsKey(identifier);

  /// Removes a variable.
  void removeVariable(String identifier) => _variables.remove(identifier);

  /// Clears all variables.
  void clearVariables() => _variables.clear();

  /// Returns a function.
  EvaluableFunction? getFunctionByIdentifier(String identifier) => _functions[identifier];

  /// Declares a new function.
  void declareFunction(EvaluableFunction function) => _functions[function.identifier] = function;

  /// Checks if the context has the corresponding function.
  bool hasFunction(String identifier) => _functions.containsKey(identifier);

  /// Removes a function.
  void removeFunction(String identifier) => _functions.remove(identifier);

  /// Clears all functions.
  void clearFunctions() => _functions.clear();

  /// Copies an object.
  Object? _copyObject(Object? object) {
    Object? copy = object;
    if (copy is List) {
      copy = copy.copy();
    } else if (copy is Map) {
      copy = copy.copy();
    } else if (copy is Set) {
      copy = copy.copy();
    }
    return copy;
  }
}

/// Allows to create a map from a list of functions.
extension MapFromEvaluableFunctionList on List<EvaluableFunction> {
  /// Creates a map from a list of functions.
  Map<String, EvaluableFunction> toMap() => {
    for (EvaluableFunction function in this) function.identifier: function,
  };
}
