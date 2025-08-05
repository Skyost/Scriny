import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('MinFunction', () {
    test('calculates minimum value', () {
      Expression expression = ScrinyParser.parseExpression('min(1, 2, 5)');
      expect(expression.evaluate(EvaluationContext()), 1);
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('min(1, "a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
  });
} 