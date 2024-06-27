class TRegister {
  String fullName, username, password, confirmPassword, gender;

  TRegister({
    required this.fullName,
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.gender,
  });

  Map<String, dynamic> toJSON() {
    return {
      'fullName': fullName,
      'username': username,
      'password': password,
      'confirmPassword': confirmPassword,
      'gender': gender,
    };
  }
}
