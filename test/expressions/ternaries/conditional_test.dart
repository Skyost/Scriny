import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('ConditionalExpression', () {
    test('evaluates to "first"', () {
      ConditionalExpression expression = const ConditionalExpression(
        first: BooleanLiteral(value: true),
        second: NumberLiteral(value: 1),
        third: NumberLiteral(value: 2),
      );
      expect(expression.evaluate(EvaluationContext()), 1);
    });
  });
}
