import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('and parse', () {
    test('parses true && false', () {
      expect(
        ScrinyParser.parseExpression('true && false'),
        const AndExpression(
          left: BooleanLiteral(value: true),
          right: BooleanLiteral(value: false),
        ),
      );
    });
    test('throws on non-boolean and', () {
      expect(() => ScrinyParser.parseExpression('1 && true').evaluate(EvaluationContext()), throwsArgumentError);
      expect(() => ScrinyParser.parseExpression('true && 1').evaluate(EvaluationContext()), throwsArgumentError);
    });
  });
  group('and evaluation', () {
    test('evaluates true && false', () {
      expect(
        ScrinyParser.tryParseProgram('true && false')?.run(),
        false,
      );
    });
    test('evaluates true && true', () {
      expect(
        ScrinyParser.tryParseProgram('true && true')?.run(),
        true,
      );
    });
  });
}
