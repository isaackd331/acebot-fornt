class TermModel {
  final String? description;
  final String? version;
  final String? content;

  TermModel(
      {required this.description,
      required this.version,
      required this.content});

  factory TermModel.fromJson(Map<String, dynamic> json) => TermModel(
        description: json['description'] as String?,
        version: json['version'] as String,
        content: json['content'] as String,
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'version': version,
        'content': content,
      };
}
