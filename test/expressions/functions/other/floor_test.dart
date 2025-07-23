import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('floor', () {
    test('calculates floor', () {
      Expression expression = ScrinyParser.parseExpression('floor(1.8)');
      expect(expression.evaluate(EvaluationContext()), 1);
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('floor("a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('floor()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('floor(1, 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 