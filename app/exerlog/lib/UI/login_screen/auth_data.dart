class AuthData {
  String password;
  String email;
  String? confirmPassword;

  AuthData({required this.email, required this.password, this.confirmPassword});
}
