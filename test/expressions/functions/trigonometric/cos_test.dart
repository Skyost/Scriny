import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('cos', () {
    test('calculates cosine', () {
      Expression expression = ScrinyParser.parseExpression('cos(0)');
      expect(expression.evaluate(EvaluationContext()), closeTo(1, 1e-10));
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('cos("a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('cos()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('cos(1, 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 