import 'package:flutter/material.dart';
import 'package:library_management/providers/book_provider.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
          ListTile(
            title: Text('Sort Order'),
            trailing: DropdownButton<String>(
              value: themeProvider.sortOrder,
              onChanged: (value) {
                themeProvider.setSortOrder(value!);
                Provider.of<BookProvider>(context, listen: false).fetchBooks(value);
              },
              items: [
                DropdownMenuItem(
                  child: Text('Title'),
                  value: 'title',
                ),
                DropdownMenuItem(
                  child: Text('Author'),
                  value: 'author',
                ),
                DropdownMenuItem(
                  child: Text('Rating'),
                  value: 'rating',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
