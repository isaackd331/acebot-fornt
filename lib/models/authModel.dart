class AuthModel {
  final String? accessToken;
  final String? refreshToken;

  AuthModel({required this.accessToken, required this.refreshToken});

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String);

  Map<String, dynamic> toJson() =>
      {'accessToken': accessToken, 'refreshToken': refreshToken};
}
