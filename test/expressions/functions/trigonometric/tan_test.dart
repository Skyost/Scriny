import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('tan', () {
    test('calculates tangent', () {
      Expression expression = ScrinyParser.parseExpression('tan(0)');
      expect(expression.evaluate(EvaluationContext()), closeTo(0, 1e-10));
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('tan("a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('tan()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('tan(1, 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 