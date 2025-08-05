// ignore_for_file: prefer_const_constructors

import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('NumberLiteral', () {
    test('evaluates to number', () {
      NumberLiteral expression = NumberLiteral(value: 42);
      expect(expression.evaluate(EvaluationContext()), 42);
    });
    test('parses integer', () {
      NumberLiteral expression = NumberLiteral.parse('123');
      expect(expression.value, 123);
    });
    test('parses double', () {
      NumberLiteral expression = NumberLiteral.parse('3.14');
      expect(expression.value, 3.14);
    });
    test('equality', () {
      expect(NumberLiteral(value: 1), NumberLiteral(value: 1));
      expect(NumberLiteral(value: 1), isNot(NumberLiteral(value: 2)));
    });
  });
} 