import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('ReturnStatement', () {
    test('return an expression', () {
      Program program = ScrinyParser.parseProgram('''return 2+2;''');
      expect(program.run(), 4);
    });
    test('return nothing', () {
      Program program = ScrinyParser.parseProgram('''return;''');
      expect(program.run(), null);
    });
    test('return at the first occurrence', () {
      Program program = ScrinyParser.parseProgram('''return;
return 2;''');
      expect(program.run(), null);
    });
  });
} 