import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('LengthFunction', () {
    test('calculates length of list', () {
      Expression expression = ScrinyParser.parseExpression('length([1,2,3])');
      expect(expression.evaluate(EvaluationContext()), 3);
    });
    test('calculates length of string', () {
      Expression expression = ScrinyParser.parseExpression('length("abc")');
      expect(expression.evaluate(EvaluationContext()), 3);
    });
    test('calculates length of map', () {
      Expression expression = ScrinyParser.parseExpression('length({"a":1,"b":2})');
      expect(expression.evaluate(EvaluationContext()), 2);
    });
    test('throws on too few arguments', () {
      Expression expression = ScrinyParser.parseExpression('length()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
    test('throws on too many arguments', () {
      Expression expression = ScrinyParser.parseExpression('length([1], [2])');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<WrongArgumentCountException>()));
    });
  });
} 