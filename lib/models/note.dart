class Note{
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime? latestEditDateTime;

Note( this.noteID, this.noteTitle, this.noteContent, this.createDateTime,{this.latestEditDateTime});

factory Note.fromJson(Map<String, dynamic> item) {
    return Note(
      item['noteID'],
      item['noteTitle'],
      item['noteContent'],
      DateTime.parse(item['createDateTime']),
      latestEditDateTime : item['latestEditDateTime'] != null ? DateTime.parse(item['latestEditDateTime']) : null);
  }
}