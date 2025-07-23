/// Exception thrown when the wrong number of arguments is passed to a function.
class WrongArgumentCountException implements Exception {
  /// The minimum number of arguments.
  final int min;

  /// The maximum number of arguments.
  final int? max;

  /// The number of arguments.
  final int count;

  /// Creates a new wrong argument count exception instance.
  const WrongArgumentCountException(
    this.min,
    this.max,
    this.count,
  );

  @override
  String toString() => 'Wrong number of arguments : $count. Must be between $min and ${max ?? 'infinity'}.';
}
