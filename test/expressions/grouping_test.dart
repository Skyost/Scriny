import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('GroupingExpression', () {
    test('evaluates grouped expression', () {
      Expression expression = ScrinyParser.parseExpression('(1 + 2) * 3');
      expect(expression.evaluate(EvaluationContext()), 9);
    });
    test('nested parenthesis', () {
      Expression expression = ScrinyParser.parseExpression('((2 + 2) * 2) + 1');
      expect(expression.evaluate(EvaluationContext()), 9);
    });
  });
} 