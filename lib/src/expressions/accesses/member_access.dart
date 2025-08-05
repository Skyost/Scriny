import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/expression.dart';

/// An expression that represents a member access.
class MemberAccessExpression extends Expression {
  /// The object.
  final Expression object;

  /// The member to access.
  final Expression member;

  /// Creates a new member access expression instance.
  const MemberAccessExpression({
    required this.object,
    required this.member,
  });

  @override
  Object evaluate(EvaluationContext evaluationContext) {
    Object? evaluatedObject = object.evaluate(evaluationContext);
    Object? evaluatedMember = member.evaluate(evaluationContext);
    if (evaluatedObject is List) {
      if (evaluatedMember is! int) {
        throw ArgumentError('Key must be an integer.');
      }
      return evaluatedObject[evaluatedMember];
    }
    if (evaluatedObject is String) {
      if (evaluatedMember is! int) {
        throw ArgumentError('Key must be an integer.');
      }
      return evaluatedObject[evaluatedMember];
    }
    if (evaluatedObject is Map) {
      return evaluatedObject[evaluatedMember];
    }
    throw ArgumentError('[] must be used on a string, a list or a map.');
  }

  @override
  bool operator ==(Object other) {
    if (other is! MemberAccessExpression) {
      return super == other;
    }
    return identical(this, other) || (object == other.object && member == other.member);
  }

  @override
  int get hashCode => Object.hash(object, member);
}
