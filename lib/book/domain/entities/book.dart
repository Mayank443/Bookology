class Book {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final int downloadCount;
  final String lang;
  final List<String> downloadUrls;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadCount,
    required this.lang,
    required this.downloadUrls,
  });
}
