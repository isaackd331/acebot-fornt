class UserModel {
  final String email;
  final String name;
  final String? description;
  final dynamic role;
  final List<dynamic> work;

  UserModel(
      {required this.email,
      required this.name,
      this.description,
      required this.role,
      required this.work});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      role: json['role'] as dynamic,
      work: json['work'] as List<dynamic>);

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'description': description,
        'role': role,
        'work': work
      };
}
