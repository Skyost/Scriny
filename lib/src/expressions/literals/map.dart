import 'package:scriny/src/expressions/evaluation_context.dart';
import 'package:scriny/src/expressions/literals/literal.dart';
import 'package:scriny/src/utils/utils.dart';

/// An expression that represents a map.
class MapLiteral extends Literal<Map> {
  /// Creates a new map literal instance.
  const MapLiteral({
    required super.value,
  });

  @override
  Map evaluate(EvaluationContext evaluationContext) => {
    for (final key in value.keys) key.evaluate(evaluationContext): value[key].evaluate(evaluationContext),
  };

  @override
  bool operator ==(Object other) {
    if (other is! MapLiteral) {
      return super == other;
    }
    return identical(this, other) || mapEquals(value, other.value);
  }

  @override
  int get hashCode => value.hashCode;
}
