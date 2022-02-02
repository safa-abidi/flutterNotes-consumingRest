import 'package:flutter/material.dart';

class NoteModify extends StatelessWidget {
  const NoteModify({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create one'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Note Title',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Note content',
            ),
          ),
        ],
      ),
    );
  }
}
