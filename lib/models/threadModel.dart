class Item {
  final int? threadId;
  final String? title;
  final String? createdAt;
  final String? updatedAt;

  Item({
    required this.threadId,
    required this.title,
    required this.createdAt,
    required this.updatedAt
  });
}

class ThreadModel {
  final int? total;
  final int? page;
  final int? size;
  final int? pages;
  final List<Item> items;

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
    items: json['items'] as List<Item>,
  );

  Map<String, dynamic> toJson() => {
    'total': total,
    'page': page,
    'size': size,
    'pages': pages,
    'items': items
  };
}
