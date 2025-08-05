import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('FunctionCallExpression', () {
    test('calls built-in function', () {
      Expression expression = ScrinyParser.parseExpression('abs(-5)');
      expect(expression.evaluate(EvaluationContext()), 5);
    });
    test('throws on unknown function', () {
      Expression expression = ScrinyParser.parseExpression('unknown()');
      expect(() => expression.evaluate(EvaluationContext()), throwsA(isA<UnknownIdentifierException>()));
    });
  });
} 