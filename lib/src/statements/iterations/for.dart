import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';
import 'package:scriny/src/expressions/identifier.dart';
import 'package:scriny/src/program.dart';
import 'package:scriny/src/statements/controls/keywords/break.dart';
import 'package:scriny/src/statements/controls/keywords/return.dart';
import 'package:scriny/src/statements/statement.dart';
import 'package:scriny/src/utils/utils.dart';

/// A statement that runs a list of statements for each element in a collection.
class ForStatement extends Statement {
  /// The for keyword.
  static const String keyword = 'for';

  /// The counter identifier.
  final IdentifierExpression identifier;

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
    bool shouldRestore = evaluationContext.hasIdentifierValue(identifier.identifier);
    Object? oldValue = shouldRestore ? identifier.evaluate(evaluationContext) : null;
    void onReturn() {
      if (shouldRestore) {
        evaluationContext.setIdentifierValue(identifier.identifier, oldValue);
      } else {
        evaluationContext.removeIdentifierValue(identifier.identifier);
      }
    }

    for (Object? value in collectionResult) {
      evaluationContext.setIdentifierValue(identifier.identifier, value);
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
  bool operator ==(Object other) {
    if (other is! ForStatement) {
      return super == other;
    }
    return identical(this, other) || (identifier == other.identifier && collection == other.collection && equalsDeep(body, other.body));
  }

  @override
  int get hashCode => Object.hash(identifier, collection, body);
}
