import 'dart:math' as math;

import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('LogFunction', () {
    test('calculates natural logarithm', () {
      Expression expression = ScrinyParser.parseExpression('log(${math.e})');
      expect(expression.evaluate(EvaluationContext()), closeTo(1, 1e-10));
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('log("a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('log()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('log(1, 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 