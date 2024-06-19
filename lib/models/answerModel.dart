class AnswerModel {
  final int? result_code;
  final String? description;
  final int? q_id;
  final String? question;
  final String? template_name;
  final String? main_paragraph;
  final List<dynamic>? sub_paragraph;
  final String? feedback;
  final String? date;
  final List<dynamic>? recommend_prompt;
  final String? progress_state;
  final List<dynamic>? progress_message;
  final List<dynamic>? file_list;

  AnswerModel(
      {required this.result_code,
      this.description,
      required this.q_id,
      required this.question,
      required this.template_name,
      required this.main_paragraph,
      required this.sub_paragraph,
      required this.feedback,
      required this.date,
      required this.recommend_prompt,
      required this.progress_state,
      required this.progress_message,
      required this.file_list});

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
      result_code: json['result_code'] as int?,
      description: json['description'] as String?,
      q_id: json['q_id'] as int?,
      question: json['question'] as String?,
      template_name: json['template_name'] as String?,
      main_paragraph: json['main_paragraph'] as String?,
      sub_paragraph: json['sub_paragraph'] as List<dynamic>?,
      feedback: json['feedback'] as String?,
      date: json['date'] as String?,
      recommend_prompt: json['recommend_prompt'] as List<dynamic>?,
      progress_state: json['progress_state'] as String?,
      progress_message: json['progress_message'] as List<dynamic>?,
      file_list: json['file_list'] as List<dynamic>?);

  Map<String, dynamic> toJson() => {
        'result_code': result_code,
        'description': description,
        'q_id': q_id,
        'question': question,
        'template_name': template_name,
        'main_paragraph': main_paragraph,
        'sub_paragraph': sub_paragraph,
        'feedback': feedback,
        'date': date,
        'recommend_prompt': recommend_prompt,
        'progress_State': progress_state,
        'progress_message': progress_message,
        'file_list': file_list
      };
}
