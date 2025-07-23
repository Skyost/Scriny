import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('acos', () {
    test('calculates arccosine', () {
      Expression expression = ScrinyParser.parseExpression('acos(1)');
      expect(expression.evaluate(EvaluationContext()), closeTo(0, 1e-10));
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('acos("a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('acos()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('acos(1, 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 