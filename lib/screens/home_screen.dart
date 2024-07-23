import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../providers/theme_provider.dart';
import 'add_book_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    bookProvider.fetchBooks(themeProvider.sortOrder);

    return Scaffold(
      appBar: AppBar(
        title: Text('Library Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: bookProvider.books.isEmpty
        ? Center(child: Text('No books available.'))
        : ListView.builder(
            itemCount: bookProvider.books.length,
            itemBuilder: (ctx, index) {
              final book = bookProvider.books[index];
              return ListTile(
                title: Text(book.title),
                subtitle: Text('by ${book.author}'),
                trailing: Text('Rating: ${book.rating}'),
                onTap: () {
                  // Handle book tap
                },
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddBookScreen.routeName);
        },
      ),
    );
  }
}
