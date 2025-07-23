import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('IntegerDivisionExpression', () {
    test('integer divides two numbers', () {
      expect(ScrinyParser.parseExpression('7 ~/ 2').evaluate(EvaluationContext()), 3);
    });
    test('throws on non-numeric integer division', () {
      expect(() => ScrinyParser.parseExpression('7 ~/ "a"').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
} 