import 'package:flutter/material.dart';

import 'note.dart';
import 'database.dart';
import 'note_detail_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();

    DatabaseHelper().getAllNotes().then((notes) {
      setState(() => this.notes = notes);
    });
  }

  void _navigateToNoteDetail(Note? note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NoteDetailScreen(note: note)),
    );

    DatabaseHelper().getAllNotes().then((notes) {
      setState(() => this.notes = notes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (_, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            onTap: () => _navigateToNoteDetail(note),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToNoteDetail(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
