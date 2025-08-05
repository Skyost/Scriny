import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('ExpressionStatement', () {
    test('expression statement', () {
      Program program = ScrinyParser.parseProgram('''
return 1 + 2;
''');
      expect(program.run(), 3);
    });
  });
} 