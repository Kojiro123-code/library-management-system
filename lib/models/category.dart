class Category {
  final int? id;
  String name;
  String description;

  Category({
    this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: int.parse(json['id'].toString()),
      name: json['name'].toString(),
      description: json['description'].toString(),
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}