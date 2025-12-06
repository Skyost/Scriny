import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('MapLiteral', () {
    test('evaluates to map of evaluated keys and values', () {
      MapLiteral expression = MapLiteral(
        value: {
          const StringLiteral(value: 'a'): const NumberLiteral(value: 1),
          const StringLiteral(value: 'b'): const NumberLiteral(value: 2),
        },
      );
      expect(expression.evaluate(EvaluationContext()), {'a': 1, 'b': 2});
    });
    test('value is correct', () {
      MapLiteral expression = MapLiteral(
        value: {
          const StringLiteral(value: 'x'): const NumberLiteral(value: 10),
        },
      );
      expect(expression.value.length, 1);
      expect(expression.value.keys.first, isA<StringLiteral>());
    });
    test('equality', () {
      MapLiteral a = MapLiteral(value: {const StringLiteral(value: 'k'): const NumberLiteral(value: 1)});
      MapLiteral b = MapLiteral(value: {const StringLiteral(value: 'k'): const NumberLiteral(value: 1)});
      MapLiteral c = MapLiteral(value: {const StringLiteral(value: 'k'): const NumberLiteral(value: 2)});
      expect(a, b);
      expect(a, isNot(c));
    });
  });
}
