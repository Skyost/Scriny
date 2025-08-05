import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

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