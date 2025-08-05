import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('SuperiorExpression', () {
    test('evaluates 5 > 3', () {
      expect(
        ScrinyParser.tryParseProgram('5 > 3')?.run(),
        true,
      );
    });

    test('evaluates 3 > 5', () {
      expect(
        ScrinyParser.tryParseProgram('3 > 5')?.run(),
        false,
      );
    });

    test('evaluates 5 > 5', () {
      expect(
        ScrinyParser.tryParseProgram('5 > 5')?.run(),
        false,
      );
    });

    test('evaluates 10.5 > 5.2', () {
      expect(
        ScrinyParser.tryParseProgram('10.5 > 5.2')?.run(),
        true,
      );
    });

    test('evaluates 5.2 > 10.5', () {
      expect(
        ScrinyParser.tryParseProgram('5.2 > 10.5')?.run(),
        false,
      );
    });

    test('throws on non-numeric left operand', () {
      expect(
        () => ScrinyParser.tryParseProgram('"hello" > 5')?.run(),
        throwsArgumentError,
      );
    });

    test('throws on non-numeric right operand', () {
      expect(
        () => ScrinyParser.tryParseProgram('5 > "hello"')?.run(),
        throwsArgumentError,
      );
    });
  });
} 