// Validator class hold the RegExp for requested validation

class PasswordValidator {
  /// Checks if password has minLength
  static bool hasMinLength(String password, int minLength) {
    return password.length >= minLength ? true : false;
  }

  /// Checks if password has at least 1 lowercase letter
  static bool hasMinLowerCase(String password, int minLength) {
    if (password.length < minLength) {
      return false;
    }

    for (int i = 0; i < password.length; i++) {
      if (password[i].toLowerCase() == password[i] && !isNumeric(password[i])) {
        return true;
      }
    }

    return false;
  }

  /// Checks if password length is between minLength and maxLength (inclusive)
  static bool isPasswordLengthValid(
      String password, int minLength, int maxLength) {
    return password.length >= minLength && password.length <= maxLength;
  }

  /// Checks if password has at least numericCount numeric character matches
  static bool hasMinNumericChar(String password, int numericCount) {
    String pattern = '^(.*?[0-9]){' + numericCount.toString() + ',}';
    return password.contains(RegExp(pattern));
  }

  //Checks if password has at least specialCount special character matches
  static bool hasMinSpecialChar(String password, int specialCount) {
    String pattern =
        r"^(.*?[$&+,\:;/=?@#|'<>.^*()_%!-]){" + specialCount.toString() + ",}";
    return password.contains(RegExp(pattern));
  }
}

/// Helper function to check if a character is numeric
bool isNumeric(String character) {
  return int.tryParse(character) != null;
}
