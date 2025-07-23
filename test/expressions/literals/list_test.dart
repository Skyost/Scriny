import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('ListLiteral', () {
    test('evaluates to list of evaluated elements', () {
      ListLiteral expression = ListLiteral(value: [
        NumberLiteral(value: 1),
        NumberLiteral(value: 2),
        NumberLiteral(value: 3),
      ]);
      expect(expression.evaluate(EvaluationContext()), [1, 2, 3]);
    });
    test('value is correct', () {
      ListLiteral expression = ListLiteral(value: [
        NumberLiteral(value: 4),
        NumberLiteral(value: 5),
      ]);
      expect(expression.value.length, 2);
      expect(expression.value[0], isA<NumberLiteral>());
    });
    test('equality', () {
      ListLiteral a = ListLiteral(value: [NumberLiteral(value: 1)]);
      ListLiteral b = ListLiteral(value: [NumberLiteral(value: 1)]);
      ListLiteral c = ListLiteral(value: [NumberLiteral(value: 2)]);
      expect(a, b);
      expect(a, isNot(c));
    });
  });
} 