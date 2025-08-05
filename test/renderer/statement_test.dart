import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('StatementRenderer', () {
    late DefaultStatementRenderer renderer;

    setUp(() {
      renderer = const DefaultStatementRenderer();
    });

    group('renderBlock', () {
      test('renders empty block', () {
        List<Statement> statements = [];
        expect(renderer.renderBlock(statements), equals(''));
      });

      test('renders single statement block', () {
        List<Statement> statements = [
          const ExpressionStatement(
            expression: NumberLiteral(
              value: 42,
            ),
          ),
        ];
        expect(renderer.renderBlock(statements), equals('42;'));
      });

      test('renders multiple statements block', () {
        List<Statement> statements = [
          const ExpressionStatement(
            expression: NumberLiteral(
              value: 1,
            ),
          ),
          const ExpressionStatement(
            expression: NumberLiteral(
              value: 2,
            ),
          ),
          const ExpressionStatement(
            expression: NumberLiteral(
              value: 3,
            ),
          ),
        ];
        expect(renderer.renderBlock(statements), equals('1;\n2;\n3;'));
      });
    });

    group('renderExpressionStatement', () {
      test('renders simple expression statement', () {
        ExpressionStatement statement = const ExpressionStatement(
          expression: NumberLiteral(
            value: 42,
          ),
        );
        expect(renderer.renderExpressionStatement(statement), equals('42;'));
      });

      test('renders complex expression statement', () {
        AdditionExpression expression = const AdditionExpression(
          left: NumberLiteral(
            value: 1,
          ),
          right: NumberLiteral(
            value: 2,
          ),
        );
        ExpressionStatement statement = ExpressionStatement(expression: expression);
        expect(renderer.renderExpressionStatement(statement), equals('1 + 2;'));
      });
    });

    group('renderBreakStatement', () {
      test('renders break statement', () {
        BreakStatement statement = BreakStatement();
        expect(renderer.renderBreakStatement(statement), equals('break;'));
      });
    });

    group('renderContinueStatement', () {
      test('renders continue statement', () {
        ContinueStatement statement = ContinueStatement();
        expect(renderer.renderContinueStatement(statement), equals('continue;'));
      });
    });

    group('renderReturnStatement', () {
      test('renders return statement without value', () {
        ReturnStatement statement = const ReturnStatement();
        expect(renderer.renderReturnStatement(statement), equals('return;'));
      });

      test('renders return statement with value', () {
        ReturnStatement statement = const ReturnStatement(
          value: NumberLiteral(
            value: 42,
          ),
        );
        expect(renderer.renderReturnStatement(statement), equals('return 42;'));
      });

      test('renders return statement with complex expression', () {
        MultiplicationExpression expression = const MultiplicationExpression(
          left: NumberLiteral(value: 5),
          right: NumberLiteral(value: 6),
        );
        ReturnStatement statement = ReturnStatement(
          value: expression,
        );
        expect(renderer.renderReturnStatement(statement), equals('return 5 * 6;'));
      });
    });

    group('renderIfStatement', () {
      test('renders simple if statement', () {
        BooleanLiteral condition = const BooleanLiteral(value: true);
        List<Statement> thenBranch = [
          const ExpressionStatement(
            expression: NumberLiteral(
              value: 1,
            ),
          ),
        ];
        IfStatement statement = IfStatement(
          condition: condition,
          thenBranch: thenBranch,
        );

        String expected = '''if (true) {
  1;
}''';
        expect(renderer.renderIfStatement(statement), equals(expected));
      });

      test('renders if statement with multiple statements', () {
        BooleanLiteral condition = const BooleanLiteral(value: true);
        List<Statement> thenBranch = [
          const ExpressionStatement(expression: NumberLiteral(value: 1)),
          const ExpressionStatement(expression: NumberLiteral(value: 2)),
        ];
        IfStatement statement = IfStatement(
          condition: condition,
          thenBranch: thenBranch,
        );

        String expected = '''if (true) {
  1;
  2;
}''';
        expect(renderer.renderIfStatement(statement), equals(expected));
      });

      test('renders if-else statement', () {
        BooleanLiteral condition = const BooleanLiteral(value: true);
        List<Statement> thenBranch = [const ExpressionStatement(expression: NumberLiteral(value: 1))];
        List<Statement> elseBranch = [const ExpressionStatement(expression: NumberLiteral(value: 2))];
        IfStatement statement = IfStatement(
          condition: condition,
          thenBranch: thenBranch,
          elseBranch: elseBranch,
        );

        String expected = '''if (true) {
  1;
} else {
  2;
}''';
        expect(renderer.renderIfStatement(statement), equals(expected));
      });

      test('renders if-else with complex condition', () {
        EqualityExpression condition = const EqualityExpression(
          left: NumberLiteral(value: 5),
          right: NumberLiteral(value: 5),
        );
        List<Statement> thenBranch = [const ExpressionStatement(expression: NumberLiteral(value: 1))];
        List<Statement> elseBranch = [const ExpressionStatement(expression: NumberLiteral(value: 2))];
        IfStatement statement = IfStatement(
          condition: condition,
          thenBranch: thenBranch,
          elseBranch: elseBranch,
        );

        String expected = '''if (5 == 5) {
  1;
} else {
  2;
}''';
        expect(renderer.renderIfStatement(statement), equals(expected));
      });
    });

    group('renderWhileStatement', () {
      test('renders simple while statement', () {
        BooleanLiteral condition = const BooleanLiteral(value: true);
        List<Statement> body = [const ExpressionStatement(expression: NumberLiteral(value: 1))];
        WhileStatement statement = WhileStatement(
          condition: condition,
          body: body,
        );

        String expected = '''while (true) {
  1;
}''';
        expect(renderer.renderWhileStatement(statement), equals(expected));
      });

      test('renders while statement with multiple statements', () {
        BooleanLiteral condition = const BooleanLiteral(value: true);
        List<Statement> body = [
          const ExpressionStatement(expression: NumberLiteral(value: 1)),
          const ExpressionStatement(expression: NumberLiteral(value: 2)),
        ];
        WhileStatement statement = WhileStatement(
          condition: condition,
          body: body,
        );

        String expected = '''while (true) {
  1;
  2;
}''';
        expect(renderer.renderWhileStatement(statement), equals(expected));
      });

      test('renders while with complex condition', () {
        SuperiorExpression condition = const SuperiorExpression(
          left: NumberLiteral(value: 5),
          right: NumberLiteral(value: 3),
        );
        List<Statement> body = [const ExpressionStatement(expression: NumberLiteral(value: 1))];
        WhileStatement statement = WhileStatement(
          condition: condition,
          body: body,
        );

        String expected = '''while (5 > 3) {
  1;
}''';
        expect(renderer.renderWhileStatement(statement), equals(expected));
      });
    });

    group('renderForStatement', () {
      test('renders simple for statement', () {
        IdentifierExpression identifier = const IdentifierExpression(identifier: 'i');
        ListLiteral collection = const ListLiteral(value: [NumberLiteral(value: 1), NumberLiteral(value: 2), NumberLiteral(value: 3)]);
        List<Statement> body = [const ExpressionStatement(expression: NumberLiteral(value: 1))];
        ForStatement statement = ForStatement(
          identifier: identifier,
          collection: collection,
          body: body,
        );

        String expected = '''for (i in [1, 2, 3]) {
  1;
}''';
        expect(renderer.renderForStatement(statement), equals(expected));
      });

      test('renders for statement with multiple statements', () {
        IdentifierExpression identifier = const IdentifierExpression(identifier: 'item');
        ListLiteral collection = const ListLiteral(value: [NumberLiteral(value: 1), NumberLiteral(value: 2)]);
        List<Statement> body = [
          const ExpressionStatement(expression: NumberLiteral(value: 1)),
          const ExpressionStatement(expression: NumberLiteral(value: 2)),
        ];
        ForStatement statement = ForStatement(
          identifier: identifier,
          collection: collection,
          body: body,
        );

        String expected = '''for (item in [1, 2]) {
  1;
  2;
}''';
        expect(renderer.renderForStatement(statement), equals(expected));
      });

      test('renders for with complex collection', () {
        IdentifierExpression identifier = const IdentifierExpression(identifier: 'x');
        FunctionCallExpression collection = const FunctionCallExpression(
          callee: IdentifierExpression(identifier: 'range'),
          arguments: [NumberLiteral(value: 10)],
        );
        List<Statement> body = [const ExpressionStatement(expression: NumberLiteral(value: 1))];
        ForStatement statement = ForStatement(
          identifier: identifier,
          collection: collection,
          body: body,
        );

        String expected = '''for (x in range(10)) {
  1;
}''';
        expect(renderer.renderForStatement(statement), equals(expected));
      });
    });

    group('render complex statements', () {
      test('renders nested if statements', () {
        BooleanLiteral innerCondition = const BooleanLiteral(value: false);
        List<Statement> innerThen = [const ExpressionStatement(expression: NumberLiteral(value: 2))];
        IfStatement innerIf = IfStatement(
          condition: innerCondition,
          thenBranch: innerThen,
        );

        BooleanLiteral outerCondition = const BooleanLiteral(value: true);
        List<Statement> outerThen = [innerIf];
        IfStatement outerIf = IfStatement(
          condition: outerCondition,
          thenBranch: outerThen,
        );

        String expected = '''if (true) {
  if (false) {
    2;
  }
}''';
        expect(renderer.renderIfStatement(outerIf), equals(expected));
      });

      test('renders while with break and continue', () {
        BooleanLiteral condition = const BooleanLiteral(value: true);
        List<Statement> body = [
          BreakStatement(),
          ContinueStatement(),
          const ExpressionStatement(expression: NumberLiteral(value: 1)),
        ];
        WhileStatement statement = WhileStatement(
          condition: condition,
          body: body,
        );

        String expected = '''while (true) {
  break;
  continue;
  1;
}''';
        expect(renderer.renderWhileStatement(statement), equals(expected));
      });

      test('renders for with if inside', () {
        BooleanLiteral forCondition = const BooleanLiteral(value: true);
        List<Statement> forThen = [const ExpressionStatement(expression: NumberLiteral(value: 1))];
        IfStatement forIf = IfStatement(
          condition: forCondition,
          thenBranch: forThen,
        );

        IdentifierExpression identifier = const IdentifierExpression(identifier: 'i');
        ListLiteral collection = const ListLiteral(value: [NumberLiteral(value: 1), NumberLiteral(value: 2)]);
        List<Statement> body = [forIf];
        ForStatement statement = ForStatement(
          identifier: identifier,
          collection: collection,
          body: body,
        );

        String expected = '''for (i in [1, 2]) {
  if (true) {
    1;
  }
}''';
        expect(renderer.renderForStatement(statement), equals(expected));
      });
    });
  });
}
