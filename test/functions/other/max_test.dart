import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('MaxFunction', () {
    test('calculates maximum value', () {
      Expression expression = ScrinyParser.parseExpression('max(1, 2, 5)');
      expect(expression.evaluate(EvaluationContext()), 5);
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('max(1, "a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
  });
} 