import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('sqrt', () {
    test('calculates square root', () {
      Expression expression = ScrinyParser.parseExpression('sqrt(9)');
      expect(expression.evaluate(EvaluationContext()), 3);
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('sqrt("a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('sqrt()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('sqrt(1, 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 