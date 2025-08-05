import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('ContinueStatement', () {
    test('skips iteration in for loop', () {
      Program program = ScrinyParser.parseProgram('''sum = 0;
for (x in [1, 2, 3]) {
  if (x == 2) {
    continue;
  }
  sum = sum + x;
}
return sum;''');
      expect(program.run(), 4);
    });
  });
} 