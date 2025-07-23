import 'dart:math' as math;

import 'package:scriny/scriny.dart';

/// A simple script to test the parser.
void main() {
  // A very simple example :
  String script = '''a = 1;
b = 2;
c = a + b;
if (c == 3) {
  print("2 + 1 is equal to 3, so we're good !");
} else {
  print("Something really went wrong...");
}
''';
  Program program = ScrinyParser.parseProgram(script);
  program.run();
  // Custom top-level variables and functions :
  EvaluationContext evaluationContext = EvaluationContext(
    functions: [
      ...EvaluationContext.defaultFunctions,
      RandIntFunction(),
    ],
    variables: {
      ...EvaluationContext.defaultVariables,
      'min': 0,
      'max': 10,
      'excludes': [0, 2, 4, 6, 8, 10],
    },
  );
  script = 'print(randint(min, max, excludes));';
  program = ScrinyParser.parseProgram(script, evaluationContext: evaluationContext);
  program.run();
}

/// A custom function that calculates a random integer between two integers, eventually excluding a list of integers.
/// Represents the random integer function.
class RandIntFunction extends EvaluableFunction {
  /// Creates a random integer function instance.
  const RandIntFunction()
      : super(
          identifier: 'randint',
        );

  @override
  int get minimumArguments => 0;

  @override
  int? get maximumArguments => 3;

  @override
  List<FunctionArgumentType> buildArgumentTypesList(int argumentCount) => [
        NumberArgumentType(),
        if (argumentCount >= 2) NumberArgumentType(),
        if (argumentCount >= 3) ListArgumentType<num>(),
      ];

  @override
  num run(List<Object?> arguments) {
    math.Random random = math.Random();
    if (arguments.isEmpty) {
      return random.nextBool() ? 1 : 0;
    }

    num min = arguments.first as num;
    num max;
    List excludes = [];
    if (arguments.length >= 2) {
      max = arguments[1] as num;
      if (arguments.length >= 3) {
        excludes = arguments[2] as List;
      }
    } else {
      max = min;
      min = 0;
    }

    List<num> possibles = [];
    for (num i = min; i <= max; i++) {
      if (!excludes.contains(i)) {
        possibles.add(i);
      }
    }

    if (possibles.isNotEmpty) {
      int index = (random.nextDouble() * possibles.length).floor();
      return possibles[index];
    } else {
      return min + (random.nextDouble() * (max - min + 1)).floor();
    }
  }
}
