class TLogin {
  String username, password;

  TLogin({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJSON() {
    return {
      'username': username,
      'password': password,
    };
  }
}
