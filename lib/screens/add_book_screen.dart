import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../models/book.dart';

class AddBookScreen extends StatefulWidget {
  static const routeName = '/add-book';

  final Book? book;

  AddBookScreen({this.book});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _author;
  late int _rating;
  late bool _read;

  @override
  void initState() {
    super.initState();
    _title = widget.book?.title ?? '';
    _author = widget.book?.author ?? '';
    _rating = widget.book?.rating ?? 0;
    _read = widget.book?.read ?? false;
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.book == null) {
        Provider.of<BookProvider>(context, listen: false).addBook(
          Book(
            title: _title,
            author: _author,
            rating: _rating,
            read: _read,
          ),
        );
      } else {
        Provider.of<BookProvider>(context, listen: false).updateBook(
          Book(
            id: widget.book!.id,
            title: _title,
            author: _author,
            rating: _rating,
            read: _read,
          ),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Edit Book'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _title = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a title.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _author,
                decoration: InputDecoration(labelText: 'Author'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _author = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide an author.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _rating.toString(),
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _rating = int.parse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a rating.';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: Text('Read'),
                value: _read,
                onChanged: (value) {
                  setState(() {
                    _read = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
