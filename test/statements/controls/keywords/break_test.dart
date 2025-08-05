import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('BreakStatement', () {
    test('breaks out of while loop', () {
      Program program = ScrinyParser.parseProgram('''x = 0;
while (true) {
  x = x + 1;
  if (x == 3) {
    break;
  }
}
return x;''');
      expect(program.run(), 3);
    });
  });
} 