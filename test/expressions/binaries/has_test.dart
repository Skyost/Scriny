import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('HasExpression', () {
    test('list contains number item', () {
      EvaluationContext evaluationContext = EvaluationContext();
      evaluationContext.setVariableValue('myList', [1, 2, 3, 4]);
      Object? result = ScrinyParser.parseProgram('myList has 3', evaluationContext: evaluationContext).run();
      expect(result, isTrue);
    });

    test('list does not contain number item', () {
      Object? result = ScrinyParser.parseProgram('[1, 2, 4] has 3').run();
      expect(result, isFalse);
    });

    test('list contains string item', () {
      EvaluationContext evaluationContext = EvaluationContext();
      evaluationContext.setVariableValue('strList', ["a", "b", "c"]);
      Object? result = ScrinyParser.parseProgram('strList has "b"', evaluationContext: evaluationContext).run();
      expect(result, isTrue);
    });

    test('list does not contain string item', () {
      Object? result = ScrinyParser.parseProgram('["a", "c"] has "b"').run();
      expect(result, isFalse);
    });

    test('list contains null', () {
      Object? result = ScrinyParser.parseProgram('[1, null, 3] has null').run();
      expect(result, isTrue);
    });

    test('list does not contain null when null not present', () {
      Object? result = ScrinyParser.parseProgram('[1, 2, 3] has null').run();
      expect(result, isFalse);
    });

    test('empty list "has" anything should be false', () {
      Object? result = ScrinyParser.parseProgram('[] has 1').run();
      expect(result, isFalse);
    });

    test('list "has" item of different type (eg. looking for string in num list)', () {
      Object? result = ScrinyParser.parseProgram('[1, 2, 3] has "2"').run();
      expect(result, isFalse);
    });

    test('map contains string key', () {
      Object? result = ScrinyParser.parseProgram('{"name": "Scriny", "version": 1} has "name"').run();
      expect(result, isTrue);
    });

    test('map does not contain string key', () {
      Object? result = ScrinyParser.parseProgram('{"version": 1} has "name"').run();
      expect(result, isFalse);
    });

    test('map contains number key', () {
      EvaluationContext evaluationContext = EvaluationContext();
      evaluationContext.setVariableValue('myMap', {10: 'ten', 20: 'twenty'});
      Object? result = ScrinyParser.parseProgram('myMap has 10', evaluationContext: evaluationContext).run();
      expect(result, isTrue);
    });

    test('empty map "has" any key should be false', () {
      Object? result = ScrinyParser.parseProgram('{} has "key"').run();
      expect(result, isFalse);
    });

    test('string contains substring', () {
      Object? result = ScrinyParser.parseProgram('"hello world" has "world"').run();
      expect(result, isTrue);
    });

    test('string does not contain substring', () {
      Object? result = ScrinyParser.parseProgram('"hello world" has "scriny"').run();
      expect(result, isFalse);
    });

    test('string contains substring - case sensitive', () {
      Object? result = ScrinyParser.parseProgram('"Hello World" has "world"').run();
      expect(result, isFalse);
    });

    test('string "has" empty string', () {
      Object? result = ScrinyParser.parseProgram('"hello" has ""').run();
      expect(result, isTrue);
    });

    test('empty string "has" non-empty substring', () {
      Object? result = ScrinyParser.parseProgram('"" has "a"').run();
      expect(result, isFalse);
    });

    test('empty string "has" empty string', () {
      Object? result = ScrinyParser.parseProgram('"" has ""').run();
      expect(result, isTrue);
    });

    test('string "has" number with conversion', () {
      Object? result = ScrinyParser.parseProgram('"version2" has 2').run();
      expect(result, isTrue);
    });

    test('"has" with an unsupported type', () {
      expect(
        ScrinyParser.parseProgram('123 has 2').run,
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
