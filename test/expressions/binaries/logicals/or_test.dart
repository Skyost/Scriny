import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('or parse', () {
    test('parses true || false', () {
      expect(
        ScrinyParser.parseExpression('true || false'),
        const OrExpression(
          left: BooleanLiteral(value: true),
          right: BooleanLiteral(value: false),
        ),
      );
    });
    test('throws on non-boolean or', () {
      expect(() => ScrinyParser.parseExpression('1 || true').evaluate(EvaluationContext()), throwsArgumentError);
      expect(() => ScrinyParser.parseExpression('true || 1').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
  group('or evaluation', () {
    test('evaluates true || false', () {
      expect(
        ScrinyParser.tryParseProgram('true || false')?.run(),
        true,
      );
    });
    test('evaluates true || true', () {
      expect(
        ScrinyParser.tryParseProgram('true || true')?.run(),
        true,
      );
    });
  });
}
