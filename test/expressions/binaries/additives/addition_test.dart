import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('AdditionExpression', () {
    test('adds two numbers', () {
      expect(ScrinyParser.parseExpression('2 + 3').evaluate(EvaluationContext()), 5);
    });
    test('concatenates two strings', () {
      expect(ScrinyParser.parseExpression('"a" + "b"').evaluate(EvaluationContext()), 'ab');
    });
    test('concatenates two lists', () {
      expect(ScrinyParser.parseExpression('[1,2] + [3,4]').evaluate(EvaluationContext()), [1,2,3,4]);
    });
    test('merges two maps', () {
      expect(ScrinyParser.parseExpression('{"a":1} + {"b":2}').evaluate(EvaluationContext()), {'a':1,'b':2});
    });
    test('concatenates number and string', () {
      expect(ScrinyParser.parseExpression('2 + "a"').evaluate(EvaluationContext()), '2a');
    });
  });
} 