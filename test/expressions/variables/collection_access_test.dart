import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('CollectionAccessExpression', () {
    test('accesses list element', () {
      EvaluationContext evaluationContext = EvaluationContext(variables: {'l': [1, 2, 3]});
      Expression expression = ScrinyParser.parseExpression('l[1]');
      expect(expression.evaluate(evaluationContext), 2);
    });
    test('accesses map value', () {
      EvaluationContext evaluationContext = EvaluationContext(variables: {'m': {'a': 42}});
      Expression expression = ScrinyParser.parseExpression('m["a"]');
      expect(expression.evaluate(evaluationContext), 42);
    });
    test('accesses string character', () {
      EvaluationContext evaluationContext = EvaluationContext(variables: {'s': 'abc'});
      Expression expression = ScrinyParser.parseExpression('s[1]');
      expect(expression.evaluate(evaluationContext), 'b');
    });
    test('throws on invalid key', () {
      EvaluationContext evaluationContext = EvaluationContext(variables: {'l': [1, 2, 3]});
      Expression expression = ScrinyParser.parseExpression('l["a"]');
      expect(() => expression.evaluate(evaluationContext), throwsArgumentError);
    });
  });
} 