import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('MinusExpression', () {
    test('negates a positive number', () {
      Expression expression = ScrinyParser.parseExpression('-5');
      expect(expression.evaluate(EvaluationContext()), -5);
    });
    test('negates a negative number', () {
      Expression expression = ScrinyParser.parseExpression('--5');
      expect(expression.evaluate(EvaluationContext()), 5);
    });
    test('throws on non-numeric', () {
      expect(() => ScrinyParser.parseExpression('-"a"').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
} 