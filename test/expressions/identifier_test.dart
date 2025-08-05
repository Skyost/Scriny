import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('IdentifierExpression', () {
    test('retrieves assigned variable', () {
      EvaluationContext evaluationContext = EvaluationContext(constants: {'x': 42});
      Expression expression = ScrinyParser.parseExpression('x');
      expect(expression.evaluate(evaluationContext), 42);
    });
  });
} 