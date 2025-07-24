import 'dart:math' as math;

import 'package:scriny/src/expressions/functions/functions.dart';
import 'package:scriny/src/parser.dart';
import 'package:scriny/src/utils/copy.dart';
import 'package:scriny/src/utils/type_acceptor.dart';

/// Allows to hold variables and functions for evaluations.
class EvaluationContext {
  /// The accepted types.
  static const List<TypeAcceptor> _acceptedValuesTypes = [
    BooleanTypeAcceptor(),
    NumberTypeAcceptor(),
    StringTypeAcceptor(),
    ListTypeAcceptor(),
    MapTypeAcceptor(),
    NullTypeAcceptor(),
  ];

  /// Checks if a variable value can be used.
  static bool isVariableValueValid(Object? value) => _acceptedValuesTypes.any((type) => type.accept(value));

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
  }) : _variables = Map.of(variables),
       _functions = functions.toMap(),
       assert(
         [
           for (MapEntry<String, Object?> variable in variables.entries)
             if (!ScrinyParser.isValidIdentifier(variable.key) || !isVariableValueValid(variable.value)) variable.key,
         ].isEmpty,
         'Invalid identifier or value used in the variables list.',
       ),
       assert(
         [
           for (EvaluableFunction function in functions)
             if (!ScrinyParser.isValidIdentifier(function.identifier)) function.identifier,
         ].isEmpty,
         'Invalid identifier in functions.',
       );

  /// Returns a variable value.
  Object? getVariableValue(String identifier) => _copyObject(_variables[identifier]);

  /// Sets a variable value.
  Object? setVariableValue(String identifier, Object? value) {
    if (!ScrinyParser.isValidIdentifier(identifier)) {
      throw ArgumentError('Invalid identifier : $identifier.');
    }
    if (!isVariableValueValid(value)) {
      throw ArgumentError('Invalid value : $value.');
    }
    return _variables[identifier] = _copyObject(value);
  }

  /// Checks if the context has the corresponding variable.
  bool hasVariable(String identifier) => _variables.containsKey(identifier);

  /// Removes a variable.
  void removeVariable(String identifier) => _variables.remove(identifier);

  /// Clears all variables.
  void clearVariables() => _variables.clear();

  /// Returns a function.
  EvaluableFunction? getFunctionByIdentifier(String identifier) => _functions[identifier];

  /// Declares a new function.
  void declareFunction(EvaluableFunction function) {
    if (!ScrinyParser.isValidIdentifier(function.identifier)) {
      throw ArgumentError('Invalid identifier : ${function.identifier}.');
    }
    _functions[function.identifier] = function;
  }

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
