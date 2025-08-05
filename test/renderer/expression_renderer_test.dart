import 'package:scriny/scriny.dart';
import 'package:test/test.dart';

void main() {
  group('ExpressionRenderer', () {
    late DefaultExpressionRenderer renderer;

    setUp(() {
      renderer = const DefaultExpressionRenderer();
    });

    group('renderIdentifier', () {
      test('renders identifier expression', () {
        IdentifierExpression expression = const IdentifierExpression(identifier: 'x');
        expect(renderer.renderIdentifier(expression), equals('x'));
      });

      test('renders complex identifier', () {
        IdentifierExpression expression = const IdentifierExpression(identifier: 'myVariable');
        expect(renderer.renderIdentifier(expression), equals('myVariable'));
      });
    });

    group('renderParenthesis', () {
      test('renders grouping expression', () {
        NumberLiteral operand = const NumberLiteral(value: 42);
        GroupingExpression expression = GroupingExpression(operand: operand);
        expect(renderer.renderParenthesis(expression), equals('(42)'));
      });

      test('renders nested grouping', () {
        NumberLiteral inner = const NumberLiteral(value: 10);
        GroupingExpression outer = GroupingExpression(
          operand: GroupingExpression(operand: inner),
        );
        expect(renderer.renderParenthesis(outer), equals('((10))'));
      });
    });

    group('renderLiteral', () {
      test('renders number literal', () {
        NumberLiteral literal = const NumberLiteral(value: 42);
        expect(renderer.renderLiteral(literal), equals('42'));
      });

      test('renders string literal', () {
        StringLiteral literal = const StringLiteral(value: 'hello');
        expect(renderer.renderLiteral(literal), equals('"hello"'));
      });

      test('renders boolean literal', () {
        BooleanLiteral literal = const BooleanLiteral(value: true);
        expect(renderer.renderLiteral(literal), equals('true'));
      });

      test('renders null literal', () {
        NullLiteral literal = const NullLiteral();
        expect(renderer.renderLiteral(literal), equals('null'));
      });

      test('renders list literal', () {
        ListLiteral literal = const ListLiteral(
          value: [
            NumberLiteral(value: 1),
            NumberLiteral(value: 2),
            NumberLiteral(value: 3),
          ],
        );
        expect(renderer.renderLiteral(literal), equals('[1, 2, 3]'));
      });

      test('renders empty list literal', () {
        ListLiteral literal = const ListLiteral(value: []);
        expect(renderer.renderLiteral(literal), equals('[]'));
      });

      test('renders map literal', () {
        MapLiteral literal = const MapLiteral(
          value: {
            'a': NumberLiteral(value: 1),
            'b': StringLiteral(value: 'hello'),
          },
        );
        expect(renderer.renderLiteral(literal), equals('{"a": 1, "b": "hello"}'));
      });

      test('renders empty map literal', () {
        MapLiteral literal = const MapLiteral(value: {});
        expect(renderer.renderLiteral(literal), equals('{}'));
      });
    });

    group('renderFunctionCall', () {
      test('renders function call with no arguments', () {
        IdentifierExpression callee = const IdentifierExpression(identifier: 'func');
        FunctionCallExpression expression = FunctionCallExpression(
          callee: callee,
          arguments: [],
        );
        expect(renderer.renderFunctionCall(expression), equals('func()'));
      });

      test('renders function call with arguments', () {
        IdentifierExpression callee = const IdentifierExpression(identifier: 'add');
        List<Expression> args = [const NumberLiteral(value: 1), const NumberLiteral(value: 2)];
        FunctionCallExpression expression = FunctionCallExpression(
          callee: callee,
          arguments: args,
        );
        expect(renderer.renderFunctionCall(expression), equals('add(1, 2)'));
      });

      test('renders nested function call', () {
        FunctionCallExpression innerCall = const FunctionCallExpression(
          callee: IdentifierExpression(identifier: 'inner'),
          arguments: [NumberLiteral(value: 5)],
        );
        FunctionCallExpression outerCall = FunctionCallExpression(
          callee: const IdentifierExpression(identifier: 'outer'),
          arguments: [innerCall],
        );
        expect(renderer.renderFunctionCall(outerCall), equals('outer(inner(5))'));
      });
    });

    group('renderMemberAccess', () {
      test('renders member access', () {
        IdentifierExpression object = const IdentifierExpression(identifier: 'array');
        NumberLiteral member = const NumberLiteral(value: 0);
        MemberAccessExpression expression = MemberAccessExpression(
          object: object,
          member: member,
        );
        expect(renderer.renderMemberAccess(expression), equals('array[0]'));
      });

      test('renders nested member access', () {
        MemberAccessExpression inner = const MemberAccessExpression(
          object: IdentifierExpression(identifier: 'obj'),
          member: StringLiteral(value: 'prop'),
        );
        MemberAccessExpression outer = MemberAccessExpression(
          object: inner,
          member: const NumberLiteral(value: 1),
        );
        expect(renderer.renderMemberAccess(outer), equals('obj["prop"][1]'));
      });
    });

    group('renderUnary', () {
      test('renders unary minus', () {
        NumberLiteral operand = const NumberLiteral(value: 5);
        MinusExpression expression = MinusExpression(operand: operand);
        expect(renderer.renderUnary(expression), equals('-5'));
      });

      test('renders unary not', () {
        BooleanLiteral operand = const BooleanLiteral(value: true);
        NotExpression expression = NotExpression(operand: operand);
        expect(renderer.renderUnary(expression), equals('!true'));
      });

      test('renders unary with parentheses for precedence', () {
        AdditionExpression operand = const AdditionExpression(
          left: NumberLiteral(value: 1),
          right: NumberLiteral(value: 2),
        );
        MinusExpression expression = MinusExpression(operand: operand);
        expect(renderer.renderUnary(expression), equals('-(1 + 2)'));
      });
    });

    group('renderBinary', () {
      test('renders addition', () {
        AdditionExpression expression = const AdditionExpression(
          left: NumberLiteral(value: 1),
          right: NumberLiteral(value: 2),
        );
        expect(renderer.renderBinary(expression), equals('1 + 2'));
      });

      test('renders multiplication', () {
        MultiplicationExpression expression = const MultiplicationExpression(
          left: NumberLiteral(value: 3),
          right: NumberLiteral(value: 4),
        );
        expect(renderer.renderBinary(expression), equals('3 * 4'));
      });

      test('renders with proper precedence', () {
        AdditionExpression inner = const AdditionExpression(
          left: NumberLiteral(value: 1),
          right: NumberLiteral(value: 2),
        );
        MultiplicationExpression outer = MultiplicationExpression(
          left: inner,
          right: const NumberLiteral(value: 3),
        );
        expect(renderer.renderBinary(outer), equals('(1 + 2) * 3'));
      });

      test('renders equality comparison', () {
        EqualityExpression expression = const EqualityExpression(
          left: NumberLiteral(value: 5),
          right: NumberLiteral(value: 5),
        );
        expect(renderer.renderBinary(expression), equals('5 == 5'));
      });

      test('renders logical and', () {
        AndExpression expression = const AndExpression(
          left: BooleanLiteral(value: true),
          right: BooleanLiteral(value: false),
        );
        expect(renderer.renderBinary(expression), equals('true && false'));
      });
    });

    group('render complex expressions', () {
      test('renders complex nested expression', () {
        AdditionExpression expression = const AdditionExpression(
          left: MultiplicationExpression(
            left: NumberLiteral(value: 2),
            right: GroupingExpression(operand: NumberLiteral(value: 3)),
          ),
          right: FunctionCallExpression(
            callee: IdentifierExpression(identifier: 'sqrt'),
            arguments: [NumberLiteral(value: 16)],
          ),
        );
        expect(renderer.renderExpression(expression), equals('2 * (3) + sqrt(16)'));
      });

      test('renders expression with all types', () {
        EqualityExpression expression = const EqualityExpression(
          left: MemberAccessExpression(
            object: IdentifierExpression(identifier: 'array'),
            member: NumberLiteral(value: 0),
          ),
          right: FunctionCallExpression(
            callee: IdentifierExpression(identifier: 'getValue'),
            arguments: [StringLiteral(value: 'key')],
          ),
        );
        expect(renderer.renderExpression(expression), equals('array[0] == getValue("key")'));
      });
    });
  });
}
