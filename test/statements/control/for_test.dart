import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('ForStatement', () {
    test('sums list elements', () {
      Program program = ScrinyParser.parseProgram('''sum = 0;
for (x in [1, 2, 3]) {
  sum = sum + x;
}
return sum;''');
      expect(program.run(), 6);
    });
  });
} 