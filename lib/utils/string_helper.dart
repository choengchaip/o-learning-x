class StringHelper {
  StringHelper._();

  static String capitalize(String? text) {
    if (text == null) {
      return '';
    }
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }
}
