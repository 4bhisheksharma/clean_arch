/// Prints an informational [message] to stdout.
void logInfo(String message) {
  print(message);
}

/// Prints a success [message] to stdout.
void logSuccess(String message) {
  print(message);
}

/// Prints an error [message] to stdout.
void logError(String message) {
  print(message);
}

/// Prints a "Creating `path`" log line to stdout.
void logCreate(String message) {
  print('Creating $message');
}