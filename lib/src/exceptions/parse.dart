import 'package:petitparser/petitparser.dart';

/// An exception thrown when Scriny cannot parse some source code.
class ScrinyParseException implements Exception {
  /// The source code that failed to parse.
  final String source;

  /// The parser failure.
  final Failure failure;

  /// Creates a new Scriny parse exception.
  const ScrinyParseException({
    required this.source,
    required this.failure,
  });

  @override
  String toString() => 'Could not parse Scriny source at ${failure.position}: ${failure.message}';
}
