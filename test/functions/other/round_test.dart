import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('RoundFunction', () {
    test('calculates round', () {
      Expression expression = ScrinyParser.parseExpression('round(1.5)');
      expect(expression.evaluate(EvaluationContext()), 2);
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('round("a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('round()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('round(1, 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 