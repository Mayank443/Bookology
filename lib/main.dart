import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'book/presentation/screens/book_list_screen.dart';

void main() {
  runApp(const Bookology());
}

class Bookology extends StatelessWidget {
  const Bookology({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Discovery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BookListScreen(),
    );
  }
}
