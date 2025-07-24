import 'package:scriny/src/utils/type_acceptor.dart';

/// Exception thrown when an argument is of the wrong type.
class FunctionArgumentTypeException implements Exception {
  /// The accepted type.
  final TypeAcceptor acceptedType;

  /// The type of the argument.
  final Type type;

  /// Creates a new argument type exception instance.
  const FunctionArgumentTypeException(
    this.acceptedType,
    this.type,
  );

  @override
  String toString() => 'Wrong argument type : $type. Must validate $acceptedType.';
}
