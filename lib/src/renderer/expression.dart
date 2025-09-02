import 'package:meta/meta.dart';
import 'package:scriny/src/expressions/expressions.dart';

/// A mixin for rendering expressions.
mixin ExpressionRenderer {
  /// Renders an expression.
  String renderExpression(Expression expression);

  /// Renders a Dart string.
  /// Note that it's not a [Literal] nor a [Literal.value].
  String renderString(String string) => string;
}

/// The base class for expression renderers.
abstract class ExpressionRendererBase with ExpressionRenderer {
  /// Creates a new expression renderer instance.
  const ExpressionRendererBase();

  @override
  String renderExpression(Expression expression) {
    if (expression is IdentifierExpression) {
      return renderIdentifier(expression);
    }
    if (expression is GroupingExpression) {
      return renderParenthesis(expression);
    }
    if (expression is Literal) {
      return renderLiteral(expression);
    }
    if (expression is FunctionCallExpression) {
      return renderFunctionCall(expression);
    }
    if (expression is MemberAccessExpression) {
      return renderMemberAccess(expression);
    }
    if (expression is BinaryExpression) {
      return renderBinary(expression);
    }
    if (expression is UnaryExpression) {
      return renderUnary(expression);
    }
    return renderString(expression.toString());
  }

  /// Renders an identifier.
  String renderIdentifier(IdentifierExpression expression) => expression.identifier;

  /// Renders a parenthesis.
  String renderParenthesis(GroupingExpression expression) => renderString('(') + renderExpression(expression.operand) + renderString(')');

  /// Renders a literal.
  String renderLiteral(Literal literal) {
    Object? value = literal.value;
    if (value is List) {
      String result = renderString('[');
      for (int i = 0; i < value.length; i++) {
        result += renderLiteralValue(value[i]);
        if (i < value.length - 1) {
          result += renderString(', ');
        }
      }
      result += renderString(']');
      return result;
    }
    if (value is Map) {
      String result = renderString('{');
      for (int i = 0; i < value.length; i++) {
        result += renderLiteralValue(value.keys.elementAt(i)) + renderString(': ') + renderLiteralValue(value.values.elementAt(i));
        if (i < value.length - 1) {
          result += renderString(', ');
        }
      }
      result += renderString('}');
      return result;
    }
    return renderLiteralValue(value);
  }

  /// Renders a literal value.
  String renderLiteralValue(Object? value) {
    if (value is String) {
      return renderString('"') + renderString(value) + renderString('"');
    }
    return renderString(value.toString());
  }

  /// Renders a function call.
  String renderFunctionCall(FunctionCallExpression expression) {
    String result = renderExpression(expression.callee) + renderString('(');
    for (int i = 0; i < expression.arguments.length; i++) {
      result += renderExpression(expression.arguments[i]);
      if (i < expression.arguments.length - 1) {
        result += renderString(', ');
      }
    }
    result += renderString(')');
    return result;
  }

  /// Renders a member access.
  String renderMemberAccess(MemberAccessExpression expression) => renderExpression(expression.object) + renderString('[') + renderExpression(expression.member) + renderString(']');

  /// Renders a binary expression.
  String renderBinary(BinaryExpression expression) => renderExpression(expression.left) + renderString(' ${expression.operator} ') + renderExpression(expression.right);

  /// Renders a unary expression.
  String renderUnary(UnaryExpression expression) {
    String result = renderString(expression.operator);
    if (expression is DeleteExpression) {
      result += renderString(' ');
    }
    ExpressionPrecedence? precedence = ExpressionPrecedence.of(expression);
    if (precedence == null) {
      result += renderExpression(expression.operand);
    } else {
      ExpressionPrecedence? operandPrecedence = ExpressionPrecedence.of(expression.operand);
      if (operandPrecedence != null && operandPrecedence < precedence) {
        result += renderString('(') + renderExpression(expression.operand) + renderString(')');
      } else {
        result += renderExpression(expression.operand);
      }
    }
    return result;
  }
}

/// A mixin for rendering binary expressions without neglecting the associativity.
mixin AssociativityAware on ExpressionRendererBase {
  @override
  String renderBinary(BinaryExpression expression) {
    String result = '';

    bool shouldParenthesizeLeft = shouldParenthesize(expression: expression, isLeft: true);
    if (shouldParenthesizeLeft) {
      result += renderString('(');
    }
    result += renderExpression(expression.left);
    if (shouldParenthesizeLeft) {
      result += renderString(')');
    }

    result += renderString(' ${expression.operator} ');

    bool shouldParenthesizeRight = shouldParenthesize(expression: expression, isLeft: false);
    if (shouldParenthesizeRight) {
      result += renderString('(');
    }
    result += renderExpression(expression.right);
    if (shouldParenthesizeRight) {
      result += renderString(')');
    }

    return result;
  }

  /// Returns `true` if the child should be parenthesized in the [toString] representation.
  bool shouldParenthesize({
    required BinaryExpression expression,
    required bool isLeft,
  }) {
    ExpressionPrecedence? currentOperatorPrecedence = ExpressionPrecedence.of(expression);
    Expression childExpression = isLeft ? expression.left : expression.right;
    ExpressionPrecedence? childPrecedence = ExpressionPrecedence.of(childExpression);

    if (currentOperatorPrecedence == null || childPrecedence == null) {
      return false;
    }

    if (childPrecedence < currentOperatorPrecedence) {
      return true;
    }

    if (childPrecedence > currentOperatorPrecedence) {
      return false;
    }

    if (isLeftAssociative(expression)) {
      if (!isLeft) {
        return true;
      }
    } else if (isRightAssociative(expression)) {
      if (isLeft) {
        return true;
      }
    } else if (!isLeftAssociative(expression) && !isRightAssociative(expression)) {
      return true;
    }

    return false;
  }

  /// Returns `true` if the [expression] is left associative.
  @protected
  bool isLeftAssociative(BinaryExpression expression);

  /// Returns `true` if the [expression] is right associative.
  @protected
  bool isRightAssociative(BinaryExpression expression);
}

/// Represents the precedence of an expression.
/// References :
/// - https://learn.microsoft.com/en-us/cpp/c-language/precedence-and-order-of-evaluation
/// - https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_precedence
/// - https://matthieu-moy.fr/cours/poly-c/html/node343.html
enum ExpressionPrecedence {
  /// The precedence of an assignment expression.
  assignment,

  /// The precedence of an or expression.
  or,

  /// The precedence of an and expression.
  and,

  /// The precedence of an equality expression.
  equality,

  /// The precedence of a relational expression.
  relational,

  /// The precedence of an additive expression.
  additive,

  /// The precedence of a multiplicative expression.
  multiplicative,

  /// The precedence of an exponentiation expression.
  exponentiation,

  /// The precedence of a unary expression.
  unary,

  /// The precedence of a grouping expression.
  grouping,

  /// The precedence of an identifier expression.
  identifier;

  /// Returns the precedence of the [expression].
  static ExpressionPrecedence? of(Expression expression) {
    if (expression is AssignmentExpression) {
      return assignment;
    }
    if (expression is OrExpression) {
      return or;
    }
    if (expression is AndExpression) {
      return and;
    }
    if (expression is InEqualityGroup) {
      return equality;
    }
    if (expression is InRelationalGroup) {
      return relational;
    }
    if (expression is InAdditiveGroup) {
      return additive;
    }
    if (expression is InMultiplicativeGroup) {
      return multiplicative;
    }
    if (expression is InExponentiationGroup) {
      return exponentiation;
    }
    if (expression is UnaryExpression) {
      return unary;
    }
    if (expression is GroupingExpression) {
      return grouping;
    }
    if (expression is IdentifierExpression) {
      return identifier;
    }
    return null;
  }

  /// Allows to compare the precedence of two expressions.
  bool operator <(ExpressionPrecedence other) => index < other.index;

  /// Allows to compare the precedence of two expressions.
  bool operator >(ExpressionPrecedence other) => index > other.index;
}

/// The default expression renderer.
class DefaultExpressionRenderer extends ExpressionRendererBase with AssociativityAware {
  /// Creates a new default expression renderer instance.
  const DefaultExpressionRenderer();

  @override
  @protected
  bool isLeftAssociative(BinaryExpression expression) =>
      expression is MemberAccessExpression ||
      expression is InMultiplicativeGroup ||
      expression is InAdditiveGroup ||
      expression is InRelationalGroup ||
      expression is InEqualityGroup ||
      expression is InLogicalGroup;

  @override
  @protected
  bool isRightAssociative(BinaryExpression expression) => !isLeftAssociative(expression);
}

/// The mathematical expression renderer.
class MathematicalExpressionRenderer extends ExpressionRendererBase with AssociativityAware {
  /// Creates a new mathematical expression renderer instance.
  const MathematicalExpressionRenderer();

  @override
  @protected
  bool isLeftAssociative(BinaryExpression expression) => expression is AdditionExpression || expression is MultiplicationExpression || expression is AndExpression || expression is OrExpression;

  @override
  @protected
  bool isRightAssociative(BinaryExpression expression) =>
      expression is AdditionExpression || expression is MultiplicationExpression || expression is AndExpression || expression is OrExpression || expression is InExponentiationGroup;
}
