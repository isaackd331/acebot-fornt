class AnswerModel {
  final int? result_code;
  final String? description;
  final int? q_id;
  final String? question;
  final String? template_name;
  final String? main_paragraph;
  final List<Map<String?, dynamic>>? sub_paragraph;
  final int? feedback;
  final String? date;

  AnswerModel({
    required this.result_code,
    required this.description,
    required this.q_id,
    required this.question,
    required this.template_name,
    required this.main_paragraph,
    required this.sub_paragraph,
    required this.feedback,
    required this.date
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
    result_code: json['result_code'] as int,
    description: json['description'] as String,
    q_id: json['q_id'] as int,
    question: json['question'] as String,
    template_name: json['template_name'] as String,
    main_paragraph: json['main_paragraph'] as String,
    sub_paragraph: json['sub_paragraph'] as List<Map<String?, dynamic>>,
    feedback: json['feedback'] as int,
    date: json['date'] as String
  );

  Map<String, dynamic> toJson() => {
    'result_code': result_code,
    'description': description,
    'q_id': q_id,
    'question': question,
    'template_name': template_name,
    'main_paragraph': main_paragraph,
    'sub_paragraph': sub_paragraph,
    'feedback': feedback,
    'date': date
  };
}
