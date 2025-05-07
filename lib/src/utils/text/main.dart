class TextUtils {
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String toCamelCase(String text) {
    return text.split(' ').map((word) => capitalize(word)).join('');
  }

  static String toSnakeCase(String text) {
    return text.replaceAll(' ', '_').toLowerCase();
  }
  
}
