import 'dart:io';

import 'package:scriny/src/expressions/functions/function.dart';

/// Represents the print function.
class PrintFunction extends EvaluableFunction {
  /// Creates a print function instance.
  const PrintFunction()
      : super(
          identifier: 'print',
        );

  @override
  Object? run(List<Object?> arguments) {
    for (Object? argument in arguments) {
      stdout.writeln(argument);
    }
    return null;
  }
}
