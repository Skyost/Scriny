import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('StringLiteral', () {
    test('evaluates to string', () {
      StringLiteral expression = StringLiteral(value: 'hello');
      expect(expression.evaluate(EvaluationContext()), 'hello');
    });
    test('value is correct', () {
      StringLiteral expression = StringLiteral(value: 'world');
      expect(expression.value, 'world');
    });
    test('equality', () {
      expect(StringLiteral(value: 'a'), StringLiteral(value: 'a'));
      expect(StringLiteral(value: 'a'), isNot(StringLiteral(value: 'b')));
    });
  });
} 