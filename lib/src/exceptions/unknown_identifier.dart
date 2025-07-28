/// Exception thrown when an unknown identifier is encountered.
class UnknownIdentifierException implements Exception {
  /// The identifier of the unknown variable.
  final String identifier;

  /// Creates a new unknown identifier exception instance.
  const UnknownIdentifierException(this.identifier);

  @override
  String toString() => 'Unknown identifier : $identifier.';
}
