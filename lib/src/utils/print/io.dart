import 'dart:io';

/// Prints the given [object] using [stdout.writeln].
void printToConsole(Object? object) {
  stdout.writeln(object?.toString());
}
