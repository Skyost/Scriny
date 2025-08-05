import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('EqualityExpression', () {
    test('evaluates 1 == 1', () {
      expect(
        ScrinyParser.tryParseProgram('1 == 1')?.run(),
        true,
      );
    });

    test('evaluates 1 == 2', () {
      expect(
        ScrinyParser.tryParseProgram('1 == 2')?.run(),
        false,
      );
    });

    test('evaluates "hello" == "hello"', () {
      expect(
        ScrinyParser.tryParseProgram('"hello" == "hello"')?.run(),
        true,
      );
    });

    test('evaluates "hello" == "world"', () {
      expect(
        ScrinyParser.tryParseProgram('"hello" == "world"')?.run(),
        false,
      );
    });

    test('evaluates true == true', () {
      expect(
        ScrinyParser.tryParseProgram('true == true')?.run(),
        true,
      );
    });

    test('evaluates true == false', () {
      expect(
        ScrinyParser.tryParseProgram('true == false')?.run(),
        false,
      );
    });

    test('evaluates [1, 2] == [1, 2]', () {
      expect(
        ScrinyParser.tryParseProgram('[1, 2] == [1, 2]')?.run(),
        true,
      );
    });

    test('evaluates [1, 2] == [1, 3]', () {
      expect(
        ScrinyParser.tryParseProgram('[1, 2] == [1, 3]')?.run(),
        false,
      );
    });

    test('evaluates {"a": 1} == {"a": 1}', () {
      expect(
        ScrinyParser.tryParseProgram('{"a": 1} == {"a": 1}')?.run(),
        true,
      );
    });

    test('evaluates {"a": 1} == {"a": 2}', () {
      expect(
        ScrinyParser.tryParseProgram('{"a": 1} == {"a": 2}')?.run(),
        false,
      );
    });
  });
}
