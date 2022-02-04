import 'package:notes_app/models/note_for_listing.dart';

class NotesService {
  List<NoteForListing> getNotesList() {
    return [
      NoteForListing("1", "note 1", DateTime.now(), DateTime.now()),
      NoteForListing("2", "note 2", DateTime.now(), DateTime.now()),
      NoteForListing("3", "note 3", DateTime.now(), DateTime.now()),
    ];
  }
}
