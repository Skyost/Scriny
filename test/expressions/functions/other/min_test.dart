import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('min', () {
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