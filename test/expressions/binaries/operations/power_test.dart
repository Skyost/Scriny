import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('PowerExpression', () {
    test('power of two numbers', () {
      expect(ScrinyParser.parseExpression('2 ^ 3').evaluate(EvaluationContext()), 8);
    });
    test('throws on non-numeric power', () {
      expect(() => ScrinyParser.parseExpression('2 ^ "a"').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
} 