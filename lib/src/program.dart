import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/parser.dart';
import 'package:scriny/src/statements/control/keywords/return.dart';
import 'package:scriny/src/statements/statement.dart';

/// Represents a runnable program.
class Program {
  /// The list of statements.
  final List<Statement> statements;

  /// The evaluation context.
  final EvaluationContext evaluationContext;

  /// Creates a new algorithm instance.
  Program({
    this.statements = const [],
    EvaluationContext? evaluationContext,
  }) : evaluationContext = evaluationContext ?? EvaluationContext();

  /// Parses an algorithm from a string.
  factory Program.parse(
    String algorithm, {
    EvaluationContext? evaluationContext,
  }) => Program(
    statements: ScrinyParser.parseStatements(algorithm),
    evaluationContext: evaluationContext,
  );

  /// Runs the algorithm.
  Object? run() {
    RunResult? result = statements.run(evaluationContext);
    return result is ReturnResult ? result.value : null;
  }

  @override
  String toString() {
    String result = '';
    for (Statement statement in statements) {
      result += '$statement\n';
    }
    return result;
  }
}

/// Allows to run the list of statements.
extension RunExtension on List<Statement> {
  /// Runs the current list of statements.
  RunResult? run(EvaluationContext context) {
    for (Statement statement in this) {
      RunResult? result = statement.run(context);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
