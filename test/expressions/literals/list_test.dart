import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('ListLiteral', () {
    test('evaluates to list of evaluated elements', () {
      ListLiteral expression = const ListLiteral(value: [
        NumberLiteral(value: 1),
        NumberLiteral(value: 2),
        NumberLiteral(value: 3),
      ]);
      expect(expression.evaluate(EvaluationContext()), [1, 2, 3]);
    });
    test('value is correct', () {
      ListLiteral expression = const ListLiteral(value: [
        NumberLiteral(value: 4),
        NumberLiteral(value: 5),
      ]);
      expect(expression.value.length, 2);
      expect(expression.value[0], isA<NumberLiteral>());
    });
    test('equality', () {
      ListLiteral a = const ListLiteral(value: [NumberLiteral(value: 1)]);
      ListLiteral b = const ListLiteral(value: [NumberLiteral(value: 1)]);
      ListLiteral c = const ListLiteral(value: [NumberLiteral(value: 2)]);
      expect(a, b);
      expect(a, isNot(c));
    });
  });
} 