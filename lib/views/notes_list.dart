import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/models/api_response.dart';
import 'package:notes_app/models/note_for_listing.dart';
import 'package:notes_app/services/notes_service.dart';
import 'package:notes_app/views/delete_note.dart';
import 'package:notes_app/views/note_modify.dart';

class NotesList extends StatefulWidget {
  NotesList({Key? key}) : super(key: key);

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  NotesService get service => GetIt.instance<NotesService>();

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  late APIResponse<List<NoteForListing>> _apiResponse;
  late bool _isLoading = false;

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
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
              .push(MaterialPageRoute(builder: (_) => NoteModify()))
              .then((_) {
            _fetchNotes();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_apiResponse.error != null) {
            return Center(
              child: Text(_apiResponse.errorMessage ?? ''),
            );
          } else {
            return ListView.separated(
                itemBuilder: (_, index) {
                  return Dismissible(
                    key: ValueKey(_apiResponse.data![index].noteID),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {},
                    confirmDismiss: (direction) async {
                      final result = await showDialog(
                          context: context, builder: (_) => NoteDelete());
                      return result;
                    },
                    background: Container(
                      color: Colors.red,
                      padding: EdgeInsets.only(left: 16),
                      child: Align(
                        child: Icon(Icons.delete, color: Colors.white),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        _apiResponse.data![index].noteTitle,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      subtitle: Text(
                        'Last edited on ${formatDateTime(_apiResponse.data![index].latestEditDateTime ?? _apiResponse.data![index].createDateTime)}',
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => NoteModify(
                                noteID: _apiResponse.data![index].noteID)));
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      color: Colors.green,
                    ),
                itemCount: _apiResponse.data!.length);
          }
        },
      ),
    );
  }
}
