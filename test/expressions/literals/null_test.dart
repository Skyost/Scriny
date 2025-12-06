import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('NullLiteral', () {
    test('evaluates to null', () {
      NullLiteral expression = const NullLiteral();
      expect(expression.evaluate(EvaluationContext()), null);
    });
    test('equality', () {
      expect(const NullLiteral(), const NullLiteral());
    });
  });
}
