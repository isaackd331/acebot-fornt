class PromptModel {
  final String? description;
  final List<dynamic> prompts;

  PromptModel({required this.description, required this.prompts});

  factory PromptModel.fromJson(Map<String, dynamic> json) => PromptModel(
        description: json['description'] as String?,
        prompts: json['prompts'] as List<dynamic>,
      );

  Map<String, dynamic> toJson() =>
      {'description': description, 'prompts': prompts};
}
