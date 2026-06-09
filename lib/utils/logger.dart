import 'dart:io';

/// Lightweight, dependency-free console logger.
///
/// Informational and success output goes to `stdout`; warnings and errors go
/// to `stderr` so they can be filtered/piped independently. ANSI colors are
/// auto-detected and can be toggled with [setLogColorsEnabled].

const String _reset = '\x1B[0m';
const String _cyan = '\x1B[36m';
const String _green = '\x1B[32m';
const String _yellow = '\x1B[33m';
const String _red = '\x1B[31m';
const String _grey = '\x1B[90m';

bool _colorsEnabled = stdout.supportsAnsiEscapes;

/// Enables or disables ANSI colors. Colors are auto-detected by default.
void setLogColorsEnabled(bool enabled) => _colorsEnabled = enabled;

String _paint(String code, String message) =>
    _colorsEnabled ? '$code$message$_reset' : message;

/// Prints an informational [message] to stdout.
void logInfo(String message) => stdout.writeln(_paint(_cyan, message));

/// Prints a success [message] to stdout.
void logSuccess(String message) => stdout.writeln(_paint(_green, message));

/// Prints a warning [message] to stderr.
void logWarning(String message) =>
    stderr.writeln(_paint(_yellow, 'Warning: $message'));

/// Prints an error [message] to stderr.
void logError(String message) =>
    stderr.writeln(_paint(_red, 'Error: $message'));

/// Logs that a file or directory was created at [path].
void logCreate(String path) => stdout.writeln(_paint(_green, 'created  $path'));

/// Logs that a file at [path] was skipped because it already exists.
void logSkip(String path) =>
    stdout.writeln(_paint(_grey, 'skipped  $path  (already exists)'));
