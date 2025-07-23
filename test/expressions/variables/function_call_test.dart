import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

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