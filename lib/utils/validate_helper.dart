import 'package:o_learning_x/utils/regex_helper.dart';

class ValidateHelper {
  static bool isEmailValid(String email) {
    if (new RegExp(RegexHelper.emailRegex).hasMatch(email)) {
      return true;
    }

    return false;
  }

  static bool isPasswordValid(String password) {
    if (password.length > 6) {
      return true;
    }

    return false;
  }
}
