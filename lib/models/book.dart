class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String? coverUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    this.coverUrl,
  });
}
