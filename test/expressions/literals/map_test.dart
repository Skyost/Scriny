import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('MapLiteral', () {
    test('evaluates to map of evaluated keys and values', () {
      MapLiteral expression = MapLiteral(value: {
        StringLiteral(value: 'a'): NumberLiteral(value: 1),
        StringLiteral(value: 'b'): NumberLiteral(value: 2),
      });
      expect(expression.evaluate(EvaluationContext()), {'a': 1, 'b': 2});
    });
    test('value is correct', () {
      MapLiteral expression = MapLiteral(value: {
        StringLiteral(value: 'x'): NumberLiteral(value: 10),
      });
      expect(expression.value.length, 1);
      expect(expression.value.keys.first, isA<StringLiteral>());
    });
    test('equality', () {
      MapLiteral a = MapLiteral(value: {StringLiteral(value: 'k'): NumberLiteral(value: 1)});
      MapLiteral b = MapLiteral(value: {StringLiteral(value: 'k'): NumberLiteral(value: 1)});
      MapLiteral c = MapLiteral(value: {StringLiteral(value: 'k'): NumberLiteral(value: 2)});
      expect(a, b);
      expect(a, isNot(c));
    });
  });
} 