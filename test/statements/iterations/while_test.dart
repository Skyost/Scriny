import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('WhileStatement', () {
    test('increments variable', () {
      Program program = ScrinyParser.parseProgram('''x = 0;
while (x < 3) {
  x = x + 1;
}
return x;''');
      expect(program.run(), 3);
    });
  });
} 