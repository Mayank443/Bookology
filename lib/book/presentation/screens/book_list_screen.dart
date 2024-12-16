import 'package:bookology/book/presentation/widgets/book_tile.dart';
import 'package:bookology/book/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../data/datasources/book_remote_data_source.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../domain/entities/book.dart';
import '../../domain/usecases/get_books.dart';
 

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late final GetBooks _getBooks;
  List<Book> books = [];
  bool isLoading = false;
  int page = 1;
  bool hasMore = true;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
 

  @override
  void initState() {
    super.initState();
    final bookRepository = BookRepositoryImpl(
      remoteDataSource: BookRemoteDataSourceImpl(
        client: http.Client(),
      ),
    );
    _getBooks = GetBooks(bookRepository);
    _loadBooks();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          searchQuery = query;
          books.clear();
          page = 1;
          hasMore = true;
        });
        _loadBooks();
      }
    });
  }

  Future<void> _loadBooks() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      final result = await _getBooks.execute(page, searchQuery: searchQuery);
      final newBooks = result['books'] as List<Book>;
      final hasMorePages = result['hasMore'] as bool;

      if (mounted) {
        setState(() {
          if (newBooks.isNotEmpty) {
            books.addAll(newBooks);
            page++;
          }
          hasMore = hasMorePages;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load books: $e'),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: _loadBooks,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(224, 211, 175, 0.9),
      appBar: CustomAppBar(
      searchController: _searchController,
      onSearchChanged: _onSearchChanged,
    ),
      body: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  books.clear();
                  page = 1;
                  hasMore = true;
                });
                await _loadBooks();
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (!isLoading &&
                      hasMore &&
                      scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200) {
                    _loadBooks();
                  }
                  return false;
                },
                child: books.isEmpty && !isLoading
                    ? const Center(
                        child: Text('No books found'),
                      )
                    : ListView.builder(
                        itemCount: books.length + (isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == books.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          var book = books[index];
                          return BookTile(
                            h: height*.3,
                            w: width,
                            url: book.coverUrl, 
                            tittle: book.title, 
                            author: book.author, 
                            downloads: book.downloadCount, 
                            book: book, 
                            language: book.lang
                          );
                        },
                      ),
              ),
            ),
    );
  }
}
