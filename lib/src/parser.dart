import 'package:petitparser/petitparser.dart';
import 'package:scriny/src/expressions/expressions.dart';
import 'package:scriny/src/program.dart';
import 'package:scriny/src/statements/statements.dart';
import 'package:scriny/src/utils/utils.dart';

/// A parser for expressions and statements.
class ScrinyParser {
  /// Reserved keywords that cannot be used as identifiers.
  static const Set<String> reservedKeywords = {
    NullLiteral.keyword,
    BooleanLiteral.trueKeyword,
    BooleanLiteral.falseKeyword,
    DeleteStatement.keyword,
    WhileStatement.keyword,
    ReturnStatement.keyword,
    ContinueStatement.keyword,
    BreakStatement.keyword,
    ForStatement.keyword,
    IfStatement.ifKeyword,
    IfStatement.elseKeyword,
  };

  /// Checks if an identifier is valid.
  static bool isValidIdentifier(String identifier) => _identifierLiteral.accept(identifier);

  /// Parses an expression from a string.
  static Expression parseExpression(String expression) => _expressionParser.end().parse(expression).value;

  /// Parses a list of statements from a string.
  static List<Statement> parseStatements(String statements) => statementListParser.end().parse(statements).value;

  /// Parses an expression or a list of statements from a string and evaluates it.
  static Program parseProgram(String expressionOrStatement, {EvaluationContext? evaluationContext}) {
    evaluationContext ??= EvaluationContext();
    Result<Expression> parseExpressionResult = _expressionParser.end().parse(expressionOrStatement);
    if (parseExpressionResult is Success) {
      return Program(
        statements: [
          ReturnStatement(value: parseExpressionResult.value),
        ],
        evaluationContext: evaluationContext,
      );
    }
    Result<List<Statement>> parseStatementsResult = statementListParser.end().parse(expressionOrStatement);
    if (parseStatementsResult is Success) {
      List<Statement> statements = parseStatementsResult.value;
      return Program(
        statements: statements,
        evaluationContext: evaluationContext,
      );
    }
    throw Exception('Invalid expression or statement provided.\n---\nExpression parse result is :\n$parseExpressionResult\n---\nProgram parse result is :\n$parseStatementsResult');
  }

  /// Parses an expression or a list of statements from a string and evaluates it, if possible.
  static Program? tryParseProgram(String expressionOrStatement, {EvaluationContext? evaluationContext}) {
    try {
      return parseProgram(expressionOrStatement, evaluationContext: evaluationContext);
    } catch (ex, stacktrace) {
      printException(ex, stacktrace);
      return null;
    }
  }
}

/// A parser for identifiers.
Parser<IdentifierExpression> _identifierLiteral = (letter() & (letter() | digit() | char('_')).star())
    .flatten()
    .trim()
    .where(
      (value) => !ScrinyParser.reservedKeywords.contains(value),
      message: 'Identifier cannot be a reserved keyword.',
    )
    .map(
      (value) => IdentifierExpression(
        identifier: value,
      ),
    );

/// A parser for expressions.
final Parser<Expression> _expressionParser = () {
  ExpressionBuilder<Expression> builder = ExpressionBuilder<Expression>();

  // An expression :
  SettableParser<Expression> expression = undefined();

  // Literals :
  Parser<NullLiteral> nullLiteral = string('null').trim().map(
    (_) => NullLiteral(),
  );
  Parser<NumberLiteral> numberLiteral = (digit().plus() & (char('.') & digit().plus()).optional()).flatten().trim().map(
    NumberLiteral.parse,
  );
  Parser<BooleanLiteral> booleanLiteral = [string('true'), string('false')].toChoiceParser().trim().map(
    BooleanLiteral.parse,
  );
  Parser<StringLiteral> stringLiteral = (char('"') & pattern('^"]*').star().flatten() & char('"')).map(
    (value) => StringLiteral(
      value: value[1],
    ),
  );
  Parser<ListLiteral> listLiteral = (char('[').trim() & expression.starSeparated(char(',').trim()).map((list) => list.elements) & char(']').trim()).map(
    (values) => ListLiteral(
      value: values[1],
    ),
  );
  Parser<MapLiteral> mapLiteral = (char('{').trim() & (expression.trim() & char(':').trim() & expression).starSeparated(char(',').trim()).map((list) => list.elements) & char('}').trim()).map(
    (values) {
      List<List> pairs = values[1] as List<List>;
      return MapLiteral(
        value: {
          for (List pair in pairs) pair[0] as Expression: pair[2] as Expression,
        },
      );
    },
  );

  // Function calls :
  Parser<List<Expression>> functionCall = (char('(').trim() & expression.starSeparated(char(',').trim()).map((list) => list.elements) & char(')').trim()).map((value) => value[1]);
  builder.primitive((_identifierLiteral & functionCall).map((value) => FunctionCallExpression(identifier: (value[0] as IdentifierExpression).identifier, arguments: value[1])));

  // Access expressions :
  Parser<Expression> collectionIndex = (char('[').trim() & expression & char(']').trim()).map((value) => value[1]);
  builder.primitive((_identifierLiteral & collectionIndex).map((value) => CollectionAccessExpression(identifier: (value[0] as IdentifierExpression).identifier, key: value[1])));

  builder
    ..primitive(nullLiteral)
    ..primitive(booleanLiteral)
    ..primitive(_identifierLiteral)
    ..primitive(numberLiteral)
    ..primitive(stringLiteral)
    ..primitive(listLiteral)
    ..primitive(mapLiteral);

  // Parenthesized expressions :
  builder.group().wrapper(
    char('(').trim(),
    char(')').trim(),
    (_, value, _) => ParenthesisExpression(
      expression: value,
    ),
  );

  // Power expressions :
  builder.group().right(
    char(PowerExpression.power).trim(),
    (left, _, right) => PowerExpression(
      left: left,
      right: right,
    ),
  );

  // Unary expressions :
  builder.group()
    ..prefix(
      char(MinusExpression.minus).trim(),
      (_, operand) => MinusExpression(
        operand: operand,
      ),
    )
    ..prefix(
      char(NotExpression.not).trim(),
      (_, operand) => NotExpression(
        operand: operand,
      ),
    );

  // Multiplicative expressions :
  builder.group()
    ..left(
      char(MultiplicationExpression.times).trim(),
      (left, _, right) => MultiplicationExpression(
        left: left,
        right: right,
      ),
    )
    ..left(
      char(DivisionExpression.divide).trim(),
      (left, _, right) => DivisionExpression(
        left: left,
        right: right,
      ),
    )
    ..left(
      char(ModulusExpression.modulus).trim(),
      (left, _, right) => ModulusExpression(
        left: left,
        right: right,
      ),
    )
    ..left(
      string(IntegerDivisionExpression.quotient).trim(),
      (left, _, right) => IntegerDivisionExpression(
        left: left,
        right: right,
      ),
    );

  // Additive expressions :
  builder.group()
    ..left(
      char(AdditionExpression.plus).trim(),
      (left, _, right) => AdditionExpression(
        left: left,
        right: right,
      ),
    )
    ..left(
      char(SubtractionExpression.minus).trim(),
      (left, _, right) => SubtractionExpression(
        left: left,
        right: right,
      ),
    );

  // Relational expressions :
  builder.group()
    ..left(
      string(SuperiorOrEqualExpression.superiorOrEqual).trim(),
      (left, _, right) => SuperiorOrEqualExpression(
        left: left,
        right: right,
      ),
    )
    ..left(
      string(InferiorOrEqualExpression.inferiorOrEqual).trim(),
      (left, _, right) => InferiorOrEqualExpression(
        left: left,
        right: right,
      ),
    )
    ..left(
      char(SuperiorExpression.superior).trim(),
      (left, _, right) => SuperiorExpression(
        left: left,
        right: right,
      ),
    )
    ..left(
      char(InferiorExpression.inferior).trim(),
      (left, _, right) => InferiorExpression(
        left: left,
        right: right,
      ),
    )
    ..left(
      string(EqualExpression.equal).trim(),
      (left, _, right) => EqualExpression(
        left: left,
        right: right,
      ),
    )
    ..left(
      string(DifferentExpression.different).trim(),
      (left, _, right) => DifferentExpression(
        left: left,
        right: right,
      ),
    );

  // Logical expressions :
  builder.group()
    ..left(
      string(AndExpression.and).trim(),
      (left, _, right) => AndExpression(
        left: left,
        right: right,
      ),
    )
    ..left(
      string(OrExpression.or).trim(),
      (left, _, right) => OrExpression(
        left: left,
        right: right,
      ),
    );

  // Has expression :
  builder.group().left(
    string(HasExpression.has).trim(),
    (left, _, right) => HasExpression(
      left: left,
      right: right,
    ),
  );

  // Expression parser is ready to use.
  expression.set(builder.build());
  return expression;
}();

/// A parser for statements.
final Parser<List<Statement>> statementListParser = () {
  // An expression :
  Parser<Expression> expression = _expressionParser;

  // A statement :
  SettableParser<Statement> statement = undefined();

  // Expression statement :
  Parser<ExpressionStatement> expressionStatement = expression.map(
    (expression) => ExpressionStatement(
      expression: expression,
    ),
  );

  // Assign statement :
  Parser<AssignStatement> assignStatement = (_identifierLiteral & char(AssignStatement.define).trim() & expression).map(
    (value) => AssignStatement(
      identifier: (value[0] as IdentifierExpression).identifier,
      value: value[2],
    ),
  );

  // Collection index assign statement :
  Parser<Expression> collectionIndex = (char('[').trim() & expression & char(']').trim()).map((value) => value[1]);
  Parser<CollectionIndexAssignStatement> collectionIndexAssignStatement = (_identifierLiteral & collectionIndex & char(AssignStatement.define).trim() & expression).map(
    (value) => CollectionIndexAssignStatement(
      identifier: (value[0] as IdentifierExpression).identifier,
      index: value[1],
      value: value[3],
    ),
  );

  // Delete statement :
  Parser<DeleteStatement> deleteStatement = (string(DeleteStatement.keyword).trim() & expression).map(
    (value) => DeleteStatement(
      expression: value[1],
    ),
  );

  // Return statement :
  Parser<ReturnStatement> returnStatement = (string(ReturnStatement.keyword).trim() & expression.optional()).map(
    (value) => ReturnStatement(
      value: value[1],
    ),
  );

  // Continue statement :
  Parser<ContinueStatement> continueStatement = string(ContinueStatement.keyword).trim().map(
    (_) => ContinueStatement(),
  );

  // Break statement :
  Parser<BreakStatement> breakStatement = string(BreakStatement.keyword).trim().map(
    (_) => BreakStatement(),
  );

  // Inline statements :
  Parser<Statement> inlineStatement =
      ([
                assignStatement,
                collectionIndexAssignStatement,
                deleteStatement,
                returnStatement,
                continueStatement,
                breakStatement,
                expressionStatement,
              ].toChoiceParser() &
              char(';').trim())
          .map(
            (value) => value[0],
          );

  // Blocks :
  Parser<List<Statement>> block = (char('{').trim() & statement.star() & char('}').trim()).map((value) => value[1]);
  Parser<IfStatement> ifStatement = (string(IfStatement.ifKeyword).trim() & char('(').trim() & expression & char(')').trim() & block & (string(IfStatement.elseKeyword).trim() & block).optional()).map(
    (value) => IfStatement(
      condition: value[2],
      thenBranch: value[4],
      elseBranch: value[5] == null ? null : value[5][1],
    ),
  );
  Parser<WhileStatement> whileStatement = (string(WhileStatement.keyword).trim() & char('(').trim() & expression & char(')').trim() & block).map(
    (value) => WhileStatement(
      condition: value[2],
      body: value[4],
    ),
  );
  Parser<ForStatement> forStatement =
      (string(ForStatement.keyword).trim() & char('(').trim() & _identifierLiteral & string('in').trim(whitespace(), whitespace()) & expression & char(')').trim() & block).map(
        (value) => ForStatement(
          identifier: (value[2] as IdentifierExpression).identifier,
          collection: value[4],
          body: value[6],
        ),
      );

  statement.set(
    [
      ifStatement,
      whileStatement,
      forStatement,
      inlineStatement,
    ].toChoiceParser(),
  );

  return statement.star();
}();
