import 'package:scriny/src/expressions/accesses/member_access.dart';
import 'package:scriny/src/expressions/binaries/assignments/group.dart';
import 'package:scriny/src/expressions/binaries/binary.dart';
import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/identifier.dart';

/// A statement that assigns a value to a variable.
class AssignmentExpression extends BinaryExpression with InAssignmentGroup {
  /// The character used to assign a value to a variable.
  static const String assign = '=';

  /// Creates a new assignment expression instance.
  const AssignmentExpression({
    required super.left,
    required super.right,
  }) : super(
         operator: assign,
       );

  @override
  Object? evaluate(EvaluationContext evaluationContext) {
    if (left is MemberAccessExpression || left is IdentifierExpression) {
      Object? evaluatedValue = right.evaluate(evaluationContext);
      if (left is MemberAccessExpression) {
        Object? evaluatedObject = (left as MemberAccessExpression).object.evaluate(evaluationContext);
        Object? evaluatedMember = (left as MemberAccessExpression).member.evaluate(evaluationContext);
        if (evaluatedObject is List) {
          if (evaluatedMember is! int) {
            throw ArgumentError('Index must be an integer.');
          }
          evaluatedObject[evaluatedMember] = evaluatedValue;
          return evaluatedValue;
        }
        if (evaluatedObject is Map) {
          evaluatedObject[evaluatedMember] = evaluatedValue;
          return evaluatedValue;
        }
        throw ArgumentError('Assignment with [] must be used on a list or a map.');
      }
      if (left is IdentifierExpression) {
        String identifier = (left as IdentifierExpression).identifier;
        Object? evaluatedValue = right.evaluate(evaluationContext);
        evaluationContext.setIdentifierValue(identifier, evaluatedValue);
        return evaluatedValue;
      }
    }
    throw ArgumentError('Invalid assignment. Left must be either a member access or an identifier.');
  }
}
