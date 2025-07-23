import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/program.dart';
import 'package:scriny/src/statements/control/keywords/break.dart';
import 'package:scriny/src/statements/control/keywords/return.dart';
import 'package:scriny/src/statements/statement.dart';
import 'package:scriny/src/utils/utils.dart';

/// A statement that runs a list of statements for each element in a collection.
class ForStatement extends Statement {
  /// The for keyword.
  static const String keyword = 'for';

  /// The counter identifier.
  final String identifier;

  /// The collection.
  final Expression collection;

  /// The body.
  final List<Statement> body;

  /// Creates a new for statement instance.
  ForStatement({
    required this.identifier,
    required this.collection,
    this.body = const [],
  });

  @override
  RunResult? run(EvaluationContext evaluationContext) {
    Object? collectionResult = collection.evaluate(evaluationContext);
    if (collectionResult is! List) {
      throw Exception('Can only iterate over a list.');
    }
    Object? oldValue = evaluationContext.getVariableValue(identifier);
    bool shouldRestore = evaluationContext.hasVariable(identifier);
    void onReturn() {
      if (shouldRestore) {
        evaluationContext.setVariableValue(identifier, oldValue);
      } else {
        evaluationContext.removeVariable(identifier);
      }
    }

    for (Object? value in collectionResult) {
      evaluationContext.setVariableValue(identifier, value);
      RunResult? result = body.run(evaluationContext);
      if (result is BreakResult) {
        break;
      } else if (result is ReturnResult) {
        onReturn();
        return result;
      }
    }
    onReturn();
    return null;
  }

  @override
  String toString() {
    String result = '$keyword ($identifier in $collection) {';
    for (Statement statement in body) {
      result += '\n  $statement';
    }
    result += '\n}';
    return result;
  }

  @override
  bool operator ==(Object other) {
    if (other is! ForStatement) {
      return super == other;
    }
    return identical(this, other) || (identifier == other.identifier && collection == other.collection && listEquals(body, other.body));
  }

  @override
  int get hashCode => Object.hash(identifier, collection, body);
}
