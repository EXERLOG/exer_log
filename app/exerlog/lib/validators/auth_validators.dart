import 'package:exerlog/validators/validator.dart';

class EmailValidator extends Validator<String> {
  EmailValidator.set(String value) : super.set(value);

  @override
  ValidationError? validator(value) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)
        ? null
        : ValidationError(message: "Enter valid email address");
  }
}

class PasswordValidator extends Validator<String> {
  PasswordValidator.set(String value) : super.set(value);

  @override
  ValidationError? validator(value) {
    if (value.isEmpty && value.length < 6) {
      return ValidationError(message: "Password must be at least 6 characters");
    }
    return null;
  }
}

class ConfirmPasswordValidator extends Validator<String> {
  final String originPassword;
  ConfirmPasswordValidator.set(String value, this.originPassword)
      : super.set(value);

  @override
  ValidationError? validator(value) {
    if (value != originPassword) {
      return ValidationError(message: "Passwords must match");
    }
    return null;
  }
}
