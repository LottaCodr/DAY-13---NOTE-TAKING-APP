class Note {
  int id;
  String title;
  String content;

  Note ({required this.id, required this.title, required this.content});
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title': title,
      'content': content
    };

  }

  Note copyWith({int? id, String? title, String? content}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  static Note fromMap( Map<String, dynamic> map) {
    return Note (
      id: map['id'],
      title: map['title'],
      content: map['content']
    );
  }
}