import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/renderer/statement.dart';

/// A statement in an algorithm.
abstract class Statement {
  /// Creates a new statement instance.
  const Statement();

  /// Runs the given statement.
  RunResult? run(EvaluationContext evaluationContext);

  @override
  String toString({
    StatementRenderer renderer = const DefaultStatementRenderer(),
  }) => renderer.renderStatement(this);
}

/// A result of a statement.
class RunResult {
  /// Creates a new result instance.
  const RunResult();
}
