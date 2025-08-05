import 'dart:math' as math;

import 'package:scriny/src/functions/functions.dart';
import 'package:scriny/src/parser.dart';
import 'package:scriny/src/utils/type_acceptor.dart';

/// Provides the necessary context for evaluating expressions : variables, constants and functions.
class EvaluationContext {
  /// The accepted types.
  static const List<TypeAcceptor> _acceptedValuesTypes = [
    BooleanTypeAcceptor(),
    NumberTypeAcceptor(),
    StringTypeAcceptor(),
    ListTypeAcceptor(),
    MapTypeAcceptor(),
    NullTypeAcceptor(),
    EvaluableFunctionTypeAcceptor(),
  ];

  /// Checks if a variable value can be used.
  static bool isVariableValueValid(Object? value) => _acceptedValuesTypes.any((type) => type.accept(value));

  /// The default constants.
  static const Map<String, Object?> defaultConstants = {
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

  /// The current values.
  final Map<String, _Value> _values;

  /// Creates a new evaluation context instance.
  EvaluationContext({
    Map<String, Object?> constants = defaultConstants,
    List<EvaluableFunction> functions = defaultFunctions,
  }) : _values = {
         for (MapEntry<String, Object?> constant in constants.entries)
           constant.key: _Value(
             value: constant.value,
             constant: true,
           ),
         for (EvaluableFunction function in functions)
           if (!constants.containsKey(function.identifier))
             function.identifier: _Value(
               value: function,
               constant: true,
             ),
       },
       assert(
         [
           for (MapEntry<String, Object?> constant in constants.entries)
             if (!ScrinyParser.isValidIdentifier(constant.key) || !isVariableValueValid(constant.value)) constant.key,
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

  /// Returns an [identifier] value.
  Object? getIdentifierValue(String identifier) => _values[identifier]?.value;

  /// Sets an [identifier] value.
  Object? setIdentifierValue(String identifier, Object? value, {bool constant = false}) {
    if (!ScrinyParser.isValidIdentifier(identifier)) {
      throw ArgumentError('Invalid identifier : $identifier.');
    }
    if (!isVariableValueValid(value)) {
      throw ArgumentError('Invalid value : $value.');
    }
    _Value? currentValue = _values[identifier];
    if (currentValue?.constant == true) {
      throw ArgumentError('Cannot modify a constant : $identifier.');
    }
    _values[identifier] = _Value(
      value: value,
      constant: constant,
    );
    return currentValue?.value;
  }

  /// Checks if the context has the corresponding value.
  bool hasIdentifierValue(String identifier) => _values.containsKey(identifier);

  /// Removes an [identifier] value.
  Object? removeIdentifierValue(String identifier) {
    _Value? currentValue = _values[identifier];
    if (currentValue?.constant == true) {
      throw ArgumentError('Cannot delete a constant : $identifier.');
    }
    return _values.remove(identifier)?.value;
  }

  /// Clears all identifiers values.
  void clearIdentifiersValues() => _values.clear();
}

/// A value, held by an [EvaluationContext].
class _Value<T> {
  /// The value.
  final T value;

  /// Whether the value is constant.
  final bool constant;

  /// Creates a new value instance.
  const _Value({
    required this.value,
    this.constant = false,
  });
}
