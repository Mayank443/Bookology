// lib/book/presentation/widgets/download_options_list.dart
import 'package:flutter/material.dart';

class DownloadOptionsList extends StatelessWidget {
  final List<String> downloadUrls;
  final Function(String) onDownloadTap;

  const DownloadOptionsList({
    super.key,
    required this.downloadUrls,
    required this.onDownloadTap,
  });

  @override
  Widget build(BuildContext context) {
    if (downloadUrls.isEmpty) {
      return const Text('No download options available');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: downloadUrls.length,
      itemBuilder: (context, index) {
        final url = downloadUrls[index];
        String format = 'Unknown';
        if (url.contains('epub')) {
          format = 'EPUB';
        } else if (url.contains('kf8')) {
          format = 'MOBI';
        } else if (url.contains('html')) {
          format = 'html';
        }
        
        final isHtml = url.contains('html');
        final type = isHtml ? 'View' : 'Download';
        final file = isHtml ? 'file' : 'Version';
        final icon = Icon(
          isHtml ? Icons.remove_red_eye_rounded : Icons.download,
          color: const Color.fromRGBO(255, 255, 208, 1),
        );
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Images/leather.jpg"),
                fit: BoxFit.cover,
              )
            ),
            child: ListTile(
              leading: icon,
              title: Text(
                '$type $format $file',
                style: const TextStyle(
                  color: Color.fromRGBO(255, 255, 208, 1),
                  fontFamily: 'NotoSans',
                ),
              ),
              onTap: () => onDownloadTap(url),
            ),
          ),
        );
      },
    );
  }
}