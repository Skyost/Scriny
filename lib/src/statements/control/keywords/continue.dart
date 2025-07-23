import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/statements/statement.dart';

/// A statement that continues the current loop.
class ContinueStatement extends Statement {
  /// The continue keyword.
  static const String keyword = 'continue';

  @override
  ContinueResult run(EvaluationContext evaluationContext) => ContinueResult();

  @override
  String toString() => '$keyword;';

  @override
  bool operator ==(Object other) {
    if (other is! ContinueStatement) {
      return super == other;
    }
    return true;
  }

  @override
  int get hashCode => keyword.hashCode;
}

/// A result of a continue statement.
class ContinueResult extends RunResult {
  /// Creates a new continue result instance.
  const ContinueResult();

  @override
  bool operator ==(Object other) {
    if (other is! ContinueResult) {
      return super == other;
    }
    return true;
  }

  @override
  int get hashCode => ContinueStatement.keyword.hashCode;
}
