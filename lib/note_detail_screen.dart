import 'package:flutter/material.dart';

import 'note.dart';
import 'database.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;

  NoteDetailScreen({this.note});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool get isEditing => widget.note != null;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      titleController.text = widget.note?.title ?? '';
      contentController.text = widget.note?.content ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Note' : 'Add Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: contentController,
              decoration: InputDecoration(hintText: 'Content'),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final content = contentController.text;

                if (isEditing) {
                  final note = widget.note?.copyWith(title: title, content: content);
                  if (note != null) {
                    DatabaseHelper().update(note);
                  }
                } else {
                  final note = Note(
                    title: title,
                    content: content,
                    id: DateTime.now().millisecondsSinceEpoch,
                  );
                  DatabaseHelper().insert(note);
                }

                Navigator.pop(context);
              },
              child: Text(isEditing ? 'Save Changes' : 'Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
