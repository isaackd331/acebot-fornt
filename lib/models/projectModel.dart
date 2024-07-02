class ProjectModel {
  final int? total;
  final int? page;
  final int? size;
  final int? pages;
  final List<dynamic> items;

  ProjectModel(
      {required this.total,
      required this.page,
      required this.size,
      required this.pages,
      required this.items});

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        total: json['total'] as int,
        page: json['page'] as int,
        size: json['size'] as int,
        pages: json['pages'] as int,
        items: json['items'] as List<dynamic>,
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'page': page,
        'size': size,
        'pages': pages,
        'items': items
      };
}
