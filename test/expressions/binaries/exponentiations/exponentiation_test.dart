import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('ExponentiationExpression', () {
    test('power of two numbers', () {
      expect(ScrinyParser.parseExpression('2 ^ 3').evaluate(EvaluationContext()), 8);
    });
    test('throws on non-numeric power', () {
      expect(() => ScrinyParser.parseExpression('2 ^ "a"').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
} 