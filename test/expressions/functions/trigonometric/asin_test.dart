import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('asin', () {
    test('calculates arcsine', () {
      Expression expression = ScrinyParser.parseExpression('asin(1)');
      expect(expression.evaluate(EvaluationContext()), closeTo(math.pi/2, 1e-10));
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('asin("a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('asin()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('asin(1, 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 