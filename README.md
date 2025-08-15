<div align="center">
  <img src="https://github.com/Skyost/Scriny/raw/main/scriny.svg" alt="Scriny" width="120"/>
</div>

&nbsp;

**Scriny** is a tiny scripting language for Dart (it's actually the concatenation of "script" and "tiny").

[![Pub Likes](https://img.shields.io/pub/likes/scriny?style=flat-square)](https://pub.dev/packages/scriny/score)
[![Pub Points](https://img.shields.io/pub/points/scriny?style=flat-square)](https://pub.dev/packages/scriny/score)
[![MIT License](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](#License)

## Features

* Evaluates simple mathematical expressions.
* Supports variables of type string, number, boolean, list, map, and null.
* Includes control structures (`if`, `else`, `for`, `while`, etc.).
* Allows custom top-level functions and variables.
* Easy to use and integrate.

Scriny is already used in two of my projects :
- [Mathonaut](https://mathonaut.skyost.eu), for parsing and evaluating mathematical expressions.
- [Révise tes maths !](https://github.com/Skyost/ReviseTesMaths), for a similar purpose.

## Getting Started

Add Scriny to your project by following the instructions [here](https://pub.dev/packages/scriny/install).

## Usage

### Code

All the code examples below can be parsed using `ScrinyParser.parseProgram` and executed using
`run()`.

#### Mathematical expressions

This evaluates to `9` :

```
(2 + 1) * 3
```

This evaluates to `8` :

```
2^3
```

This evaluates to `true` :

```
2 == (1 + 1)
```

> [!NOTE]
> To negate a boolean, use the classic `!`. You can also use `!=` instead of `==`.

This evaluates to Dart’s `math.e` :

```
exp(1)
```

> [!NOTE]
> You can find all available built-in functions [here](https://pub.dev/documentation/scriny/latest/scriny/EvaluableFunction-class.html).
> We'll see how to add custom functions later.

#### Variables

This returns `8` :

```
a = 10;
b = -2;
return a + b;
```

This throws an error :

```
a = 10;
b = -2;
delete a;
return a + b;
```

This returns `"Hello world !"` :

```
list = ["Hello"];
map = {"w": "world"};
return list[0] + " " + map["w"] + " !";
```

#### Control statements

This evaluates to `1` :

```
if (true) {
  return 1;
} else {
  return 2;
}
```

This prints `0` to `9` and returns `null` :

```
for (i in range(10)) {
  print(i);
}
```

> [!NOTE]
> If you don't return a value in your script, then `null` is returned.
> This is not the case for simple expressions (eg. `1 + 1` returns `2` once evaluated).

This returns `1998` :

```
n = 0;
while (true) {
  n = n + 1;
  if (n == 1998) {
    break;
  }
}
return n;
```

This returns `[2, 4]` :

```
list = [];
list = list + [1, 2, 3];
delete list[0];
list[1] = 4;
return list;
```

#### Custom top-level variables and functions

Adding custom top-level constants, variables and functions to Scriny is straightforward.
All you have to do is to provide a custom `EvaluationContext` to `ScrinyParser.parseProgram`.

Check out the example on [pub.dev](https://pub.dev/packages/Scriny/example), and see the
[`EvaluationContext`](https://pub.dev/documentation/scriny/latest/scriny/EvaluationContext-class.html)
class documentation for more information.

### Interpreter

Scriny comes with a built-in interpreter ! If you have a Scriny script file, you can run it with :

```bash
dart run scriny --file=<path>
```

If your script consists of a single line, you can run it with :

```bash
dart run scriny --code="<your_code>"
```

## License

This project is licensed under the [MIT License](https://github.com/Skyost/Scriny/blob/main/LICENSE).

## Contributions

There are many ways you can contribute to this project :

* [Fork it](https://github.com/Skyost/Scriny/fork) on GitHub.
* [Submit an issue](https://github.com/Skyost/Scriny/issues/new/choose) for a feature request or bug report.
* [Donate](https://paypal.me/Skyost) to support the developer.
