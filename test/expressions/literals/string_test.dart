import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('StringLiteral', () {
    test('evaluates to string', () {
      StringLiteral expression = const StringLiteral(value: 'hello');
      expect(expression.evaluate(EvaluationContext()), 'hello');
    });
    test('value is correct', () {
      StringLiteral expression = const StringLiteral(value: 'world');
      expect(expression.value, 'world');
    });
    test('equality', () {
      expect(const StringLiteral(value: 'a'), const StringLiteral(value: 'a'));
      expect(const StringLiteral(value: 'a'), isNot(const StringLiteral(value: 'b')));
    });
  });
}
