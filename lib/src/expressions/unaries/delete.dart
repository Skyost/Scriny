import 'package:scriny/src/expressions/accesses/member_access.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/identifier.dart';
import 'package:scriny/src/expressions/unaries/unary.dart';

/// A statement that unassigns a variable.
class DeleteExpression extends UnaryExpression {
  /// The delete keyword.
  static const String delete = 'delete';

  /// Creates a new delete statement instance.
  const DeleteExpression({
    required super.operand,
  }) : super(
         operator: delete,
       );

  @override
  Object? evaluate(EvaluationContext evaluationContext) {
    if (operand is IdentifierExpression) {
      return evaluationContext.removeIdentifierValue((operand as IdentifierExpression).identifier);
    }
    if (operand is MemberAccessExpression) {
      MemberAccessExpression memberAccessExpression = operand as MemberAccessExpression;

      Object? collection = memberAccessExpression.object.evaluate(evaluationContext);
      Object? member = memberAccessExpression.member.evaluate(evaluationContext);
      if (collection is List) {
        return member is int ? collection.removeAt(member) : collection.remove(member);
      }
      if (collection is Map) {
        return collection.remove(member);
      }
    }
    return null;
  }
}
