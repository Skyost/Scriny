import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

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