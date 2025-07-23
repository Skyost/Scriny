import 'package:flutter_test/flutter_test.dart';
import 'package:scriny/scriny.dart';

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