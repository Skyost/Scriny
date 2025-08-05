import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('SubtractionExpression', () {
    test('subtracts two numbers', () {
      expect(ScrinyParser.parseExpression('5 - 3').evaluate(EvaluationContext()), 2);
    });
    test('throws on non-numeric subtraction', () {
      expect(() => ScrinyParser.parseExpression('5 - "a"').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
} 