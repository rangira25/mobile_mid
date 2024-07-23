class Book {
  final int? id;
  final String title;
  final String author;
  final int rating;
  final bool read;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.rating,
    required this.read,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'rating': rating,
      'read': read ? 1 : 0,
    };
  }
}
