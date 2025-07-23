import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('BooleanLiteral', () {
    test('evaluates true', () {
      BooleanLiteral expression = BooleanLiteral(value: true);
      expect(expression.evaluate(EvaluationContext()), true);
    });
    test('evaluates false', () {
      BooleanLiteral expression = BooleanLiteral(value: false);
      expect(expression.evaluate(EvaluationContext()), false);
    });
    test('parses trueKeyword', () {
      BooleanLiteral expression = BooleanLiteral.parse(BooleanLiteral.trueKeyword);
      expect(expression.value, true);
    });
    test('parses falseKeyword', () {
      BooleanLiteral expression = BooleanLiteral.parse(BooleanLiteral.falseKeyword);
      expect(expression.value, false);
    });
    test('equality', () {
      expect(BooleanLiteral(value: true), BooleanLiteral(value: true));
      expect(BooleanLiteral(value: false), BooleanLiteral(value: false));
      expect(BooleanLiteral(value: true), isNot(BooleanLiteral(value: false)));
    });
  });
} 