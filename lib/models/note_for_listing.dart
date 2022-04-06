class NoteForListing {
  String noteID;
  String noteTitle;
  String createDateTime;
  String latestEditDateTime;

  NoteForListing({
    this.noteID,
    this.noteTitle,
    this.createDateTime,
    this.latestEditDateTime,
  });

  factory NoteForListing.fromJson(Map<String, dynamic> item) {
    return NoteForListing(
        noteID: item['id'],
        noteTitle: item['name'],
        createDateTime: item['createdDate'],
        latestEditDateTime: item['modifiedDate'] != null ? item['modifiedDate'] : null
    );
  }
}
