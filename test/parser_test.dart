import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('ScrinyParser', () {
    test('parseExpression parses valid expression', () {
      Expression expression = ScrinyParser.parseExpression('1 + 2');
      expect(expression.evaluate(EvaluationContext()), 3);
    });

    test('parseProgram parses and runs valid expression', () {
      Program program = ScrinyParser.parseProgram('1 + 2');
      expect(program.run(), 3);
    });

    test('tryParseProgram returns null on invalid input', () {
      Program? program = ScrinyParser.tryParseProgram('invalid!');
      expect(program, isNull);
    });

    test('parseExpression rejects reserved keywords as identifiers', () {
      for (String keyword in ScrinyParser.reservedKeywords) {
        expect(
          () => ScrinyParser.parseExpression('$keyword = 0;'),
          throwsA(isA<Exception>()),
          reason: 'Should not allow reserved keyword "$keyword" as identifier',
        );
      }
    });
  });
}
