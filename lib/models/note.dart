class Note {
  String noteID;
  String name;
  String description;
  String icon;
  String backgroundColor;
  String imageURL;
  String status;
  String createDateTime;
  String latestEditDateTime;

  Note({
    this.noteID,
    this.name,
    this.description,
    this.icon,
    this.backgroundColor,
    this.imageURL,
    this.status,
    this.createDateTime,
    this.latestEditDateTime,
  });

  factory Note.fromJson(Map<String, dynamic> item) {
    return Note(
        noteID: item['id'],
        name: item['name'],
        description: item['description'],
        icon: item['icon'],
        backgroundColor: item['backgroundColor'],
        imageURL: item['imageURL'],
        status: item['status'],
        createDateTime: item['createdDate'],
        latestEditDateTime: item['modifiedDate'] != null ? item['modifiedDate'] : null
    );
  }
}
