class LoginModel {
  final String db;
  final String login;
  final String password;
  final String url;
  final String? pin;
  LoginModel(
      {required this.db,
      required this.login,
      required this.url,
      required this.password,
      this.pin});
}
