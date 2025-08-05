import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('CeilFunction', () {
    test('calculates ceiling', () {
      Expression expression = ScrinyParser.parseExpression('ceil(1.2)');
      expect(expression.evaluate(EvaluationContext()), 2);
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('ceil("a")');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('ceil()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('ceil(1, 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 