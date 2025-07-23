import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('exp', () {
    test('calculates exponent', () {
      Expression expression = ScrinyParser.parseExpression('exp(2)');
      expect(expression.evaluate(EvaluationContext()), closeTo(math.exp(2), 1e-10));
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('exp("a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('exp()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('exp(1, 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 