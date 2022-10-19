// Variables
class NotesImpNames {
  static final String id = 'id';
  static final String pin = 'pin';
  static final String title = 'title';
  static final String content = 'content';
  static final String createdTime = 'createdTime';
  static final String tableName = 'Notes';

  static final List<String> values = [id, pin, title, content, createdTime];
}

// Objects and all
class Note {
  final int? id;
  final bool pin;
  final String title;
  final String content;
  final DateTime createdTime;

  Note(
      {this.id,
      required this.pin,
      required this.title,
      required this.content,
      required this.createdTime}) {}
}
