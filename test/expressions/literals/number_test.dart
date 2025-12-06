import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('NumberLiteral', () {
    test('evaluates to number', () {
      NumberLiteral expression = const NumberLiteral(value: 42);
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
      expect(const NumberLiteral(value: 1), const NumberLiteral(value: 1));
      expect(const NumberLiteral(value: 1), isNot(const NumberLiteral(value: 2)));
    });
  });
}
