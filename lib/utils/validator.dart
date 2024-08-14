class FieldValidator {
  static String? validateName(String text) {
    if (text.toString().trim().isEmpty) {
      return 'Enter name';
    } else if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(text)) {
      return 'Name must be only alphabets';
    } else if (text.toString().trim().length < 4) {
      return 'Name must be 4-alphabets';
    }
    return null;
  }

  static String? validatePassword(String? text) {
    if (text!.isEmpty) {
      return "*Required";
    } else if (text.length < 8) {
      return 'Password must be at least 8-char';
    }
    return null;
  }
}
