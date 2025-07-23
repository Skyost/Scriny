import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('ModulusExpression', () {
    test('modulus of two numbers', () {
      expect(ScrinyParser.parseExpression('7 % 2').evaluate(EvaluationContext()), 1);
    });
    test('throws on non-numeric modulus', () {
      expect(() => ScrinyParser.parseExpression('7 % "a"').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
} 