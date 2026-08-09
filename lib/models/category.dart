class Category {
  final String? id;
  String name;
  String description;

  Category({
    this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id']?.toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
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

  void displayInfo() {
    print('===========================');
    print('Category Information');
    print('===========================');
    print('ID          : $id');
    print('Name        : $name');
    print('Description : $description');
  }
}
