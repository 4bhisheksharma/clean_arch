// Helpers for normalising and validating user-supplied names so generated
// files, directories, and Dart identifiers are always valid.

/// Normalises an arbitrary [input] into a valid snake_case feature name.
///
/// Returns `null` when the input cannot produce a valid name (for example when
/// it is empty or would start with a digit after normalisation).
///
/// Examples:
/// - `"User Profile"`  -> `"user_profile"`
/// - `"userProfile"`   -> `"user_profile"`
/// - `"order-history"` -> `"order_history"`
/// - `"123"`           -> `null`
String? normalizeFeatureName(String input) {
  final snake = toSnakeCase(input);
  return isValidFeatureName(snake) ? snake : null;
}

/// Converts [input] to `snake_case`, splitting on camelCase boundaries and any
/// run of non-alphanumeric characters.
String toSnakeCase(String input) {
  var value = input.trim();
  if (value.isEmpty) {
    return '';
  }

  value = value.replaceAllMapped(
    RegExp(r'([a-z0-9])([A-Z])'),
    (match) => '${match[1]}_${match[2]}',
  );
  value = value.replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_');
  value = value.replaceAll(RegExp(r'_+'), '_');
  value = value.replaceAll(RegExp(r'^_+|_+$'), '');

  return value.toLowerCase();
}

/// Returns whether [name] is a valid snake_case feature identifier (starts with
/// a letter and contains only lowercase letters, digits, and underscores).
bool isValidFeatureName(String name) {
  return RegExp(r'^[a-z][a-z0-9_]*$').hasMatch(name);
}
