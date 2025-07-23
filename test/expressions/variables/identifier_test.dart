import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('IdentifierExpression', () {
    test('retrieves assigned variable', () {
      EvaluationContext evaluationContext = EvaluationContext(variables: {'x': 42});
      Expression expression = ScrinyParser.parseExpression('x');
      expect(expression.evaluate(evaluationContext), 42);
    });
  });
} 