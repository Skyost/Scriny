import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('Program', () {
    test('toString returns string representation', () {
      Program program = ScrinyParser.parseProgram('1 + 2;');
      expect(program.toString().trim(), isNotEmpty);
    });
    test('run returns null for empty program', () {
      Program program = Program();
      expect(program.run(), isNull);
    });
    test('nested control flow', () {
      Program program = ScrinyParser.parseProgram('''x = 0;
for (i in [1,2,3]) {
  if (i % 2 == 0) {
    x = x + i;
  }
}
return x;''');
      expect(program.run(), 2);
    });
    test('multiple statements and return', () {
      Program program = ScrinyParser.parseProgram('''a = 1;
b = 2;
c = a + b;
return c * 2;
''');
      expect(program.run(), 6);
    });
    test('while with break and continue', () {
      Program program = ScrinyParser.parseProgram('''x = 0;
y = 0;
while (x < 5) {
  x = x + 1;
  if (x == 2) {
    continue;
  }
  if (x == 4) {
    break;
  }
  y = y + x;
}
return y;''');
      expect(program.run(), 4);
    });
    test('nested control flow', () {
      Program program = ScrinyParser.parseProgram('''x = 0;
for (i in [1, 2, 3]) {
  if (i % 2 == 0) {
    x = x + i;
  }
}
return x;''');
      expect(program.run(), 2);
    });

    test('multiple statements and return', () {
      Program program = ScrinyParser.parseProgram('''a = 1;
b = 2;
c = a + b;
return c * 2;''');
      expect(program.run(), 6);
    });

    test('while with break and continue', () {
      Program program = ScrinyParser.parseProgram('''x = 0;
y = 0;
while (x < 5) {
  x = x + 1;
  if (x == 2) {
    continue;
  }
  if (x == 4) {
    break;
  }
  y = y + x;
}
return y;''');
      expect(program.run(), 4);
    });
  });
} 