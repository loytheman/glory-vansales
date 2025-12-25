class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value == "") {
      return 'Please enter email';
    }
    return "";
  }

  static String? validatePassword(String? value) {
    if (value == null || value == "") {
      return 'Please enter password';
    }
    return "";
  }
}
