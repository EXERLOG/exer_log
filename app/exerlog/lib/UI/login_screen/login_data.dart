class LoginData {
  String password;
  String email;
  String? confirmPassword;

  LoginData(
      {required this.email, required this.password, this.confirmPassword});
}
