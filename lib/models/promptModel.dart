class PromptModel {
  final String? description;
  final List<dynamic>? prompt;

  PromptModel({required this.description, required this.prompt});

  factory PromptModel.fromJson(Map<String, dynamic> json) => PromptModel(
        description: json['description'] as String?,
        prompt: json['prompt'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() =>
      {'description': description, 'prompt': prompt};
}
