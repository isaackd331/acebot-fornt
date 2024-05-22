class UserModel {
  final String? email;
  final String? name;
  final String? description;

  UserModel({required this.email, required this.name, this.description});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String,
      name: json['name'] as String,
      description: json['description'] as String?);

  Map<String, dynamic> toJson() =>
      {'email': email, 'name': name, 'description': description};
}
