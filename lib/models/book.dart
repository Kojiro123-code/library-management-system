class Book {
  final int? id;

  String title;
  String author;
  String isbn;
  int categoryId;
  int publishedYear;
  int quantity;
  int availableQuantity;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.isbn,
    required this.categoryId,
    required this.publishedYear,
    required this.quantity,
    required this.availableQuantity,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: int.parse(json['id'].toString()),
      title: json['title'].toString(),
      author: json['author'].toString(),
      isbn: json['isbn'].toString(),
      categoryId: int.parse(json['categoryId'].toString()),
      publishedYear: int.parse(json['publishedYear'].toString()),
      quantity: int.parse(json['quantity'].toString()),
      availableQuantity:
          int.parse(json['availableQuantity'].toString()),
    );
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'isbn': isbn,
      'categoryId': categoryId,
      'publishedYear': publishedYear,
      'quantity': quantity,
      'availableQuantity': availableQuantity,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'isbn': isbn,
      'categoryId': categoryId,
      'publishedYear': publishedYear,
      'quantity': quantity,
      'availableQuantity': availableQuantity,
    };
  }
}