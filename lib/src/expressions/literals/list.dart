import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/literals/literal.dart';
import 'package:scriny/src/utils/utils.dart';

/// An expression that represents a list.
class ListLiteral extends Literal<List> {
  /// Creates a new list literal instance.
  const ListLiteral({
    required super.value,
  });

  @override
  List evaluate(EvaluationContext evaluationContext) => [
    for (final value in value) value.evaluate(evaluationContext),
  ];

  @override
  bool operator ==(Object other) {
    if (other is! ListLiteral) {
      return super == other;
    }
    return identical(this, other) || equalsDeep(value, other.value);
  }

  @override
  int get hashCode => value.hashCode;
}
