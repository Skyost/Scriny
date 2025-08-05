import 'package:scriny/src/renderer/expression.dart';
import 'package:scriny/src/statements/statements.dart';

/// A mixin for rendering statements.
mixin StatementRenderer {
  /// Renders a block of statements.
  String renderBlock(List<Statement> statements);

  /// Renders a single statement.
  String renderStatement(Statement statement);

  /// Renders a Dart string.
  /// Note that it's not a [Literal] nor a [Literal.value].
  String renderString(String string);
}

/// The default statement renderer.
class DefaultStatementRenderer with StatementRenderer {
  /// Creates a new default statement renderer instance.
  final ExpressionRenderer expressionRenderer;

  /// Creates a new default statement renderer instance.
  const DefaultStatementRenderer({
    this.expressionRenderer = const DefaultExpressionRenderer(),
  });

  @override
  String renderBlock(List<Statement> statements, {String indentation = ''}) {
    String result = '';
    for (int i = 0; i < statements.length; i++) {
      result += renderStatement(statements[i], indentation: indentation);
      if (i < statements.length - 1) {
        result += renderString('\n');
      }
    }
    return result;
  }

  @override
  String renderStatement(Statement statement, {String indentation = ''}) {
    String result = renderString(indentation);
    if (statement is ExpressionStatement) {
      result += renderExpressionStatement(statement);
    } else if (statement is BreakStatement) {
      result += renderBreakStatement(statement);
    } else if (statement is ContinueStatement) {
      result += renderContinueStatement(statement);
    } else if (statement is ReturnStatement) {
      result += renderReturnStatement(statement);
    } else if (statement is IfStatement) {
      result += renderIfStatement(statement, indentation: indentation);
    } else if (statement is WhileStatement) {
      result += renderWhileStatement(statement, indentation: indentation);
    } else if (statement is ForStatement) {
      result += renderForStatement(statement, indentation: indentation);
    } else {
      result += statement.toString();
    }
    return result;
  }

  /// Renders an expression statement.
  String renderExpressionStatement(ExpressionStatement statement) => expressionRenderer.renderExpression(statement.expression) + renderString(';');

  /// Renders a break statement.
  String renderBreakStatement(BreakStatement statement) => renderString('${BreakStatement.keyword};');

  /// Renders a continue statement.
  String renderContinueStatement(ContinueStatement statement) => renderString('${ContinueStatement.keyword};');

  /// Renders a return statement.
  String renderReturnStatement(ReturnStatement statement) {
    String result = renderString(ReturnStatement.keyword);
    if (statement.value != null) {
      result += renderString(' ') + expressionRenderer.renderExpression(statement.value!);
    }
    result += renderString(';');
    return result;
  }

  /// Renders an if statement.
  String renderIfStatement(IfStatement statement, {String indentation = ''}) {
    String result = renderString('${IfStatement.ifKeyword} (') + expressionRenderer.renderExpression(statement.condition) + renderString(') {\n');
    result += renderBlock(statement.thenBranch, indentation: '$indentation  ');
    result += renderString('\n$indentation}');
    if (statement.elseBranch != null) {
      result += renderString(' else {\n');
      result += renderBlock(statement.elseBranch!, indentation: '$indentation  ');
      result += renderString('\n$indentation}');
    }
    return result;
  }

  /// Renders a while statement.
  String renderWhileStatement(WhileStatement statement, {String indentation = ''}) {
    String result = renderString('${WhileStatement.keyword} (') + expressionRenderer.renderExpression(statement.condition) + renderString(') {\n');
    result += renderBlock(statement.body, indentation: '$indentation  ');
    result += renderString('\n$indentation}');
    return result;
  }

  /// Renders a for statement.
  String renderForStatement(ForStatement statement, {String indentation = ''}) {
    String result = renderString('${ForStatement.keyword} (') + expressionRenderer.renderExpression(statement.identifier) + renderString(' in ') + expressionRenderer.renderExpression(statement.collection) + renderString(') {\n');
    result += renderBlock(statement.body, indentation: '$indentation  ');
    result += renderString('\n$indentation}');
    return result;
  }

  @override
  String renderString(String string) => expressionRenderer.renderString(string);
}
