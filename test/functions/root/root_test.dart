import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('RootFunction', () {
    test('calculates nth root', () {
      Expression expression = ScrinyParser.parseExpression('root(27, 3)');
      expect(expression.evaluate(EvaluationContext()), closeTo(3, 1e-10));
    });
    test('throws on wrong argument type', () {
      Expression expression = ScrinyParser.parseExpression('root("a", 2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<FunctionArgumentTypeException>()));
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('root(2)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('root(2, 3, 4)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 