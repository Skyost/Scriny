import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/program.dart';
import 'package:scriny/src/statements/control/keywords/break.dart';
import 'package:scriny/src/statements/control/keywords/return.dart';
import 'package:scriny/src/statements/statement.dart';
import 'package:scriny/src/utils/utils.dart';

/// A statement that runs a list of statements while the condition is true.
class WhileStatement extends Statement {
  /// The while keyword.
  static const String keyword = 'while';

  /// The condition.
  final Expression condition;

  /// The body.
  final List<Statement> body;

  /// Creates a new while statement instance.
  const WhileStatement({
    required this.condition,
    this.body = const [],
  });

  @override
  RunResult? run(EvaluationContext evaluationContext) {
    bool shouldContinue() {
      Object? conditionResult = condition.evaluate(evaluationContext);
      if (conditionResult is! bool) {
        throw Exception('Condition must be a boolean.');
      }
      return conditionResult;
    }

    while (shouldContinue()) {
      RunResult? result = body.run(evaluationContext);
      if (result is BreakResult) {
        break;
      } else if (result is ReturnResult) {
        return result;
      }
    }
    return null;
  }

  @override
  String toString() {
    String result = '$keyword ($condition) {';
    for (Statement statement in body) {
      result += '\n  $statement';
    }
    result += '\n}';
    return result;
  }

  @override
  bool operator ==(Object other) {
    if (other is! WhileStatement) {
      return super == other;
    }
    return identical(this, other) || (condition == other.condition && listEquals(body, other.body));
  }

  @override
  int get hashCode => Object.hash(condition, body);
}
