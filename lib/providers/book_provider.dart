import 'package:flutter/material.dart';
import '../db_helper.dart';
import '../models/book.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  final DBHelper _dbHelper = DBHelper();

  List<Book> get books => _books;

  BookProvider() {
    fetchBooks();
  }

  Future<void> fetchBooks([String sortOrder = 'title']) async {
    final dataList = await _dbHelper.getBooks();
    _books = dataList.map((item) => Book(
      id: item['id'],
      title: item['title'],
      author: item['author'],
      rating: item['rating'],
      read: item['read'] == 1,
    )).toList();
    _sortBooks(sortOrder);
    notifyListeners();
  }

  void addBook(Book book) async {
    await _dbHelper.insertBook(book.toMap());
    fetchBooks();
  }

  void updateBook(Book book) async {
    await _dbHelper.updateBook(book.toMap(), book.id!);
    fetchBooks();
  }

  void deleteBook(int id) async {
    await _dbHelper.deleteBook(id);
    fetchBooks();
  }

  void _sortBooks(String order) {
    if (order == 'title') {
      _books.sort((a, b) => a.title.compareTo(b.title));
    } else if (order == 'author') {
      _books.sort((a, b) => a.author.compareTo(b.author));
    } else if (order == 'rating') {
      _books.sort((a, b) => b.rating.compareTo(a.rating));
    }
    notifyListeners();
  }
}
