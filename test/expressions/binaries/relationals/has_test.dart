import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('HasExpression', () {
    test('evaluates [1, 2, 3] has 2', () {
      expect(
        ScrinyParser.tryParseProgram('[1, 2, 3] has 2')?.run(),
        true,
      );
    });

    test('evaluates [1, 2, 3] has 5', () {
      expect(
        ScrinyParser.tryParseProgram('[1, 2, 3] has 5')?.run(),
        false,
      );
    });

    test('evaluates [1, 2, 3] has "hello"', () {
      expect(
        ScrinyParser.tryParseProgram('[1, 2, 3] has "hello"')?.run(),
        false,
      );
    });

    test('evaluates "hello world" has "world"', () {
      expect(
        ScrinyParser.tryParseProgram('"hello world" has "world"')?.run(),
        true,
      );
    });

    test('evaluates "hello world" has "xyz"', () {
      expect(
        ScrinyParser.tryParseProgram('"hello world" has "xyz"')?.run(),
        false,
      );
    });

    test('evaluates "hello world" has "o"', () {
      expect(
        ScrinyParser.tryParseProgram('"hello world" has "o"')?.run(),
        true,
      );
    });

    test('evaluates {"a": 1, "b": 2} has "a"', () {
      expect(
        ScrinyParser.tryParseProgram('{"a": 1, "b": 2} has "a"')?.run(),
        true,
      );
    });

    test('evaluates {"a": 1, "b": 2} has "c"', () {
      expect(
        ScrinyParser.tryParseProgram('{"a": 1, "b": 2} has "c"')?.run(),
        false,
      );
    });

    test('evaluates {"a": 1, "b": 2} has 1', () {
      expect(
        ScrinyParser.tryParseProgram('{"a": 1, "b": 2} has 1')?.run(),
        false,
      );
    });

    test('throws on unsupported left operand type', () {
      expect(
        () => ScrinyParser.tryParseProgram('5 has 2')?.run(),
        throwsArgumentError,
      );
    });

    test('throws on unsupported left operand type with boolean', () {
      expect(
        () => ScrinyParser.tryParseProgram('true has false')?.run(),
        throwsArgumentError,
      );
    });
  });
}
