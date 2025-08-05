import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/statements/statement.dart';

/// A statement that returns a value.
class ReturnStatement extends Statement {
  /// The return keyword.
  static const String keyword = 'return';

  /// The value to return.
  final Expression? value;

  /// Creates a new return statement instance.
  const ReturnStatement({
    this.value,
  });

  @override
  ReturnResult run(EvaluationContext evaluationContext) => ReturnResult(
    value: value?.evaluate(evaluationContext),
  );

  @override
  bool operator ==(Object other) {
    if (other is! ReturnStatement) {
      return super == other;
    }
    return identical(this, other) || value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}

/// A result of a return statement.
class ReturnResult extends RunResult {
  /// The value to return.
  final Object? value;

  /// Creates a new return result instance.
  const ReturnResult({
    required this.value,
  });

  @override
  bool operator ==(Object other) {
    if (other is! ReturnResult) {
      return super == other;
    }
    return identical(this, other) || value == other.value;
  }

  @override
  int get hashCode => value.hashCode;
}
