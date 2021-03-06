class NoteForListing {
  String noteID;
  String noteTitle;
  DateTime createDateTime;
  DateTime? latestEditDateTime;

  NoteForListing(this.noteID, this.noteTitle, this.createDateTime, {this.latestEditDateTime});

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
      item['noteID'],
      item['noteTitle'],
      DateTime.parse(item['createDateTime']),
      latestEditDateTime : item['latestEditDateTime'] != null ? DateTime.parse(item['latestEditDateTime']) : null);
  }
}
