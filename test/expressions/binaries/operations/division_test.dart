import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('DivisionExpression', () {
    test('divides two integers', () {
      expect(ScrinyParser.parseExpression('6 / 3').evaluate(EvaluationContext()), 2);
    });
    test('throws on non-numeric division', () {
      expect(() => ScrinyParser.parseExpression('6 / "a"').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
} 