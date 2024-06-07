class ThreadModel {
  final int? total;
  final int? page;
  final int? size;
  final int? pages;
  final List<dynamic> items;

  ThreadModel({
    required this.total,
    required this.page,
    required this.size,
    required this.pages,
    required this.items
  });

  factory ThreadModel.fromJson(Map<String, dynamic>json) => ThreadModel(
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
