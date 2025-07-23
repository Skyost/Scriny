import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('NotExpression', () {
    test('negates true', () {
      Expression expression = ScrinyParser.parseExpression('!true');
      expect(expression.evaluate(EvaluationContext()), false);
    });
    test('negates false', () {
      Expression expression = ScrinyParser.parseExpression('!false');
      expect(expression.evaluate(EvaluationContext()), true);
    });
    test('throws on non-boolean', () {
      expect(() => ScrinyParser.parseExpression('!5').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
} 