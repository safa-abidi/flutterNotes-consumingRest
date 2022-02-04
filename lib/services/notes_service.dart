import 'dart:convert';

import 'package:notes_app/models/api_response.dart';
import 'package:notes_app/models/note_for_listing.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
  "apiKey": "9d90cf31-7330-4685-b0ca-347d119b6855"
};

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(Uri.parse('$API/notes'), headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          final note = NoteForListing(item['noteID'], item['noteTitle'],
              DateTime.parse(item['createDateTime']),
              latestEditDateTime: item['latestEditDateTime'] != null
                  ? DateTime.parse(item['latestEditDateTime'])
                  : null);
          notes.add(note);
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occured');
    })
    .catchError((_) => APIResponse<List<NoteForListing>>(error: true, errorMessage: 'An error occured'));
  }
}
