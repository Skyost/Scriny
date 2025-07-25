import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('CollectionIndexAssignStatement', () {
    test('assigns to list index', () {
      Program program = ScrinyParser.parseProgram('''
l = [1, 2, 3];
l[1] = 42;
return l[1];
''');
      expect(program.run(), 42);
    });

    test('assigns to map key', () {
      Program program = ScrinyParser.parseProgram('''
m = {"a": 1};
m["b"] = 99;
return m["b"];
''');
      expect(program.run(), 99);
    });

    test('throws on invalid collection', () {
      Program program = ScrinyParser.parseProgram('''
x = 5;
x[0] = 1;
''');
      expect(() => program.run(), throwsArgumentError);
    });
  });
} 