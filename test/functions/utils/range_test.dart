import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('RangeFunction', () {
    test('range(stop)', () {
      Expression expression = ScrinyParser.parseExpression('range(3)');
      expect(expression.evaluate(EvaluationContext()), [0, 1, 2]);
    });
    test('range(start, stop)', () {
      Expression expression = ScrinyParser.parseExpression('range(1, 4)');
      expect(expression.evaluate(EvaluationContext()), [1, 2, 3]);
    });
    test('range(start, stop, step)', () {
      Expression expression = ScrinyParser.parseExpression('range(1, 5, 2)');
      expect(expression.evaluate(EvaluationContext()), [1, 3]);
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('range()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('range(1, 2, 3, 4)');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 