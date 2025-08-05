// ignore_for_file: prefer_const_constructors

import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('NullLiteral', () {
    test('evaluates to null', () {
      NullLiteral expression = NullLiteral();
      expect(expression.evaluate(EvaluationContext()), null);
    });
    test('equality', () {
      expect(NullLiteral(), NullLiteral());
    });
  });
} 