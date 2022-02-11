import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_insert.dart';
import 'package:notes_app/services/notes_service.dart';

class NoteModify extends StatefulWidget {
  final String? noteID;
  const NoteModify({Key? key, this.noteID}) : super(key: key);

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID != null;

  NotesService get notesService => GetIt.I<NotesService>();

  String? errorMessage;
  late Note note;

  bool isLoading = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentContoller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(isEditing){
      setState(() {
      isLoading = true;
    });
    }
    

    if(isEditing){
      notesService.getNote(widget.noteID!).then((response) {

      setState(() {
        isLoading = false;
      });

      if (response.error != null) {
        errorMessage = response.errorMessage ?? 'An error occured';
      }
      note = response.data!;
      _titleController.text = note.noteTitle;
      _contentContoller.text = note.noteContent;
    });
  }
    }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit note' : 'Create note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: isLoading ? Center(child: CircularProgressIndicator()) : Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Note Title',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _contentContoller,
              decoration: InputDecoration(
                hintText: 'Note content',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              height: 35,
              child: ElevatedButton(
                onPressed: () async {
                  if(isEditing){
                    //update note
                  }else{
                    setState(() {
                      isLoading = true;
                    });
                    final note = NoteInsert(
                      _titleController.text, _contentContoller.text
                      );
                      final result = await notesService.createNote(note);

                      setState(() {
                        isLoading = false;
                      });

                      final title = 'Done';
                      final text = result.error != null ? (result.errorMessage ?? 'An error occured') : 'Your note was created';

                      showDialog(
                        context: context, 
                        builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              }, 
                              child: Text('ok'),
                              ),
                          ],
                        )
                        ).then((data) {
                          if(result.data!){
                            Navigator.of(context).pop();
                          }
                        });
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
