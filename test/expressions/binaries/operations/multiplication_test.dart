import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('MultiplicationExpression', () {
    test('multiplies two numbers', () {
      expect(ScrinyParser.parseExpression('2 * 3').evaluate(EvaluationContext()), 6);
    });
    test('throws on non-numeric multiplication', () {
      expect(() => ScrinyParser.parseExpression('2 * "a"').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
} 