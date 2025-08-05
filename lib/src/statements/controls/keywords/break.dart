import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/statements/statement.dart';

/// A statement that breaks the current loop.
class BreakStatement extends Statement {
  /// The break keyword.
  static const String keyword = 'break';

  @override
  BreakResult run(EvaluationContext evaluationContext) => const BreakResult();

  @override
  bool operator ==(Object other) {
    if (other is! BreakStatement) {
      return super == other;
    }
    return true;
  }

  @override
  int get hashCode => keyword.hashCode;
}

/// A result of a break statement.
class BreakResult extends RunResult {
  /// Creates a new break result instance.
  const BreakResult();

  @override
  bool operator ==(Object other) {
    if (other is! BreakResult) {
      return super == other;
    }
    return true;
  }

  @override
  int get hashCode => BreakStatement.keyword.hashCode;
}
