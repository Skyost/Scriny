import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('RemainderExpression', () {
    test('modulus of two numbers', () {
      expect(ScrinyParser.parseExpression('7 % 2').evaluate(EvaluationContext()), 1);
    });
    test('throws on non-numeric modulus', () {
      expect(() => ScrinyParser.parseExpression('7 % "a"').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
} 