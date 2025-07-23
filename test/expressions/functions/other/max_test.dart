import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('max', () {
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