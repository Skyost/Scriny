import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('BooleanLiteral', () {
    test('evaluates true', () {
      BooleanLiteral expression = const BooleanLiteral(value: true);
      expect(expression.evaluate(EvaluationContext()), true);
    });
    test('evaluates false', () {
      BooleanLiteral expression = const BooleanLiteral(value: false);
      expect(expression.evaluate(EvaluationContext()), false);
    });
    test('parses trueKeyword', () {
      BooleanLiteral expression = const BooleanLiteral.parse(BooleanLiteral.trueKeyword);
      expect(expression.value, true);
    });
    test('parses falseKeyword', () {
      BooleanLiteral expression = const BooleanLiteral.parse(BooleanLiteral.falseKeyword);
      expect(expression.value, false);
    });
    test('equality', () {
      expect(const BooleanLiteral(value: true), const BooleanLiteral(value: true));
      expect(const BooleanLiteral(value: false), const BooleanLiteral(value: false));
      expect(const BooleanLiteral(value: true), isNot(const BooleanLiteral(value: false)));
    });
  });
} 