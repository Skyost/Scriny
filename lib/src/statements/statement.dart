import 'package:scriny/src/expressions/evaluation_context.dart';

/// A statement in an algorithm.
abstract class Statement {
  /// Creates a new statement instance.
  const Statement();

  /// Runs the given statement.
  RunResult? run(EvaluationContext evaluationContext);
}

/// A result of a statement.
class RunResult {
  /// Creates a new result instance.
  const RunResult();
}
