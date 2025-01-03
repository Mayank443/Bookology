import 'dart:convert';
import '../../domain/entities/book.dart';

class BookModel extends Book {
  BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.coverUrl,
    required super.downloadCount,
    required super.lang,
    required super.downloadUrls,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    String decodedTitle = utf8.decode(json['title'].toString().codeUnits);
    
    String authorName = 'Unknown';
    if (json['authors'] != null && json['authors'].isNotEmpty) {
      authorName = json['authors'][0]['name'] ?? 'Unknown';
      authorName = utf8.decode(authorName.codeUnits);
    }

    String cover = 'https://via.placeholder.com/150';
    if (json['formats'] != null && json['formats']['image/jpeg'] != null) {
      cover = json['formats']['image/jpeg'];
    }

    List<String> downloads = [];
    if (json['formats'] != null) {
      if (json['formats']['text/html'] != null) {
        downloads.add(json['formats']['text/html']);
      }
      if (json['formats']['application/epub+zip'] != null) {
        downloads.add(json['formats']['application/epub+zip']);
      }
      if (json['formats']['application/x-mobipocket-ebook'] != null) {
        downloads.add(json['formats']['application/x-mobipocket-ebook']);
      }
      
    }

    return BookModel(
      id: json['id'],
      title: decodedTitle,
      author: authorName,
      coverUrl: cover,
      downloadCount: json["download_count"],
      lang: json["languages"][0],
      downloadUrls: downloads,
    );
  }
}