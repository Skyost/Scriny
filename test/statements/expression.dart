import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

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