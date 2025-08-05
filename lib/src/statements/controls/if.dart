import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/program.dart';
import 'package:scriny/src/statements/statement.dart';
import 'package:scriny/src/utils/utils.dart';

/// A statement that runs a list of statements if the condition is true.
class IfStatement extends Statement {
  /// The if keyword.
  static const String ifKeyword = 'if';

  /// The else keyword.
  static const String elseKeyword = 'else';

  /// The condition.
  final Expression condition;

  /// The list of statements to run if the condition is true.
  final List<Statement> thenBranch;

  /// The list of statements to run if the condition is false.
  final List<Statement>? elseBranch;

  /// Creates a new if statement instance.
  const IfStatement({
    required this.condition,
    this.thenBranch = const [],
    this.elseBranch,
  });

  @override
  RunResult? run(EvaluationContext evaluationContext) {
    Object? result = condition.evaluate(evaluationContext);
    if (result is! bool) {
      throw Exception('Condition must be a boolean.');
    }
    return result ? thenBranch.run(evaluationContext) : elseBranch?.run(evaluationContext);
  }

  @override
  bool operator ==(Object other) {
    if (other is! IfStatement) {
      return super == other;
    }
    return identical(this, other) || (condition == other.condition && equalsDeep(thenBranch, other.thenBranch) && equalsDeep(elseBranch, other.elseBranch));
  }

  @override
  int get hashCode => Object.hash(condition, thenBranch, elseBranch);
}
