import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('IfStatement', () {
    test('true branch', () {
      Program program = ScrinyParser.parseProgram('''if (true) {
  return 1;
} else {
  return 2;
}''');
      expect(program.run(), 1);
    });
    test('false branch', () {
      Program program = ScrinyParser.parseProgram('''if (false) {
  return 1;
} else {
  return 2;
}''');
      expect(program.run(), 2);
    });
  });
} 