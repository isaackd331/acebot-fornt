class AuthModel {
  final String? accessToken;
  final String? refreshToken;
  final String? email;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.email,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      email: json['email'] as String);

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'email': email
      };
}
