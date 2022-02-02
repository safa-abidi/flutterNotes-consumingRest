import 'package:flutter/material.dart';
import 'package:notes_app/models/note_for_listing.dart';
import 'package:notes_app/views/note_modify.dart';

class NotesList extends StatelessWidget {
  NotesList({Key? key}) : super(key: key);

  final notes = [
    NoteForListing("1", "note 1", DateTime.now(), DateTime.now()),
    NoteForListing("2", "note 2", DateTime.now(), DateTime.now()),
    NoteForListing("3", "note 3", DateTime.now(), DateTime.now()),
  ];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NoteModify()));
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(
                notes[index].noteTitle,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              subtitle: Text(
                  'Last edited on ${formatDateTime(notes[index].lastEdited)}'),
            );
          },
          separatorBuilder: (_, __) => const Divider(
                height: 1,
                color: Colors.green,
              ),
          itemCount: notes.length),
    );
  }
}
