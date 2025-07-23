import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('ParenthesisExpression', () {
    test('evaluates grouped expression', () {
      Expression expression = ScrinyParser.parseExpression('(1 + 2) * 3');
      expect(expression.evaluate(EvaluationContext()), 9);
    });
    test('nested parenthesis', () {
      Expression expression = ScrinyParser.parseExpression('((2))');
      expect(expression.evaluate(EvaluationContext()), 2);
    });
  });
} 