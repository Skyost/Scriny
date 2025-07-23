import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

void main() {
  group('AssignmentStatement', () {
    test('assigns and returns variable', () {
      Program program = ScrinyParser.parseProgram('x = 5; return x;');
      expect(program.run(), 5);
    });
  });
} 