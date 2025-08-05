import 'dart:io';

import 'package:args/args.dart';
import 'package:scriny/scriny.dart';

/// Parses the provided content and executes it.
void main(List<String> args) {
  ArgParser parser = ArgParser();
  parser.addOption(
    'file',
    abbr: 'f',
    help: 'Opens a file, parses it and executes it.',
    valueHelp: 'path',
  );
  parser.addOption(
    'string',
    abbr: 's',
    help: 'Parses the provided content and executes it.',
    valueHelp: 'string',
  );
  parser.addFlag(
    'print-return',
    abbr: 'r',
    help: 'Prints the returned value.',
    defaultsTo: true,
  );
  parser.addFlag(
    'help',
    abbr: 'h',
    help: 'Prints this help message.',
    negatable: false,
  );
  ArgResults results = parser.parse(args);
  if (results.flag('help')) {
    stdout.writeln(parser.usage);
    return;
  }

  String? content = results.option('string');
  if (results.option('file') != null) {
    File file = File(results.option('file')!);
    if (file.existsSync()) {
      content = file.readAsStringSync();
    } else {
      stderr.writeln('File "${results.option('file')}" does not exist.');
    }
  }

  if (content == null) {
    stderr.writeln('No input provided.');
    exitCode = -1;
    return;
  }

  try {
    Program program = ScrinyParser.parseProgram(content);
    Object? value = program.run();
    if (results.flag('print-return')) {
      if (value == null) {
        stdout.writeln('Returned value is null.');
      } else {
        stdout.writeln('Returned value : $value.');
      }
    }
  } catch (ex, stacktrace) {
    stderr.writeln('An error occurred !');
    stderr.writeln(ex);
    stderr.writeln(stacktrace);
    exitCode = -2;
  }
}
