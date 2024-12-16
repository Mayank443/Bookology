// lib/book/presentation/screens/book_detail_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/book.dart';
import '../widgets/book_details_header.dart';
import '../widgets/download_options_list.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({
    super.key,
    required this.book,
  });

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromRGBO(255, 252, 208, 1),
        title:Text(
      'Bookology',
      style: GoogleFonts.oldenburg(
        textStyle: const TextStyle(
          color: Color.fromRGBO(255, 252, 208, 1),
          fontSize: 26,
        ),
      ),
    ),
        flexibleSpace: const Image(
        image: AssetImage("assets/Images/leather.jpg"),
        fit: BoxFit.cover,
      ),
      ),
      body: Container(
        width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/Images/bl05.jpeg"),
              fit: BoxFit.cover,
              opacity: .75
            )
            ),
        child: SingleChildScrollView(
          
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height*.03,
                ),
                Container(
                  height: height*.5,
                  width: width*.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                                  imageUrl: book.coverUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const SizedBox(
                                    width: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                  ),
                ),
                SizedBox(
                  height: height*.5,
                  width: width*.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BookDetailsHeader(
                        title: book.title,
                        author:book.author,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'View/Download Options',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontFamily: 'NotoSans',
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),
                      DownloadOptionsList(
                        downloadUrls: book.downloadUrls,
                        onDownloadTap: _launchURL,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
