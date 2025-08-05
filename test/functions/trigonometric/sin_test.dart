import 'dart:math' as math;

import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('SinFunction', () {
    test('calculates sine', () {
      Expression expression = ScrinyParser.parseExpression('sin(${math.pi}/2)');
      expect(expression.evaluate(EvaluationContext()), closeTo(1, 1e-10));
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('sin("a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('sin()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('sin(1, 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 