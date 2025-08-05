import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('DeleteStatement', () {
    test('deletes variable', () {
      Program program = ScrinyParser.parseProgram('''x = 5;
delete x;
return x;''');
      expect(program.run, throwsA(isA<UnknownIdentifierException>()));
    });
    test('deletes from a list index', () {
      Program program = ScrinyParser.parseProgram('''list = [];
list = list + [1, 2, 3];
delete list[0];
list[1] = 4;
return list;''');
      expect(program.run(), [2,4]);
    });
  });
}
