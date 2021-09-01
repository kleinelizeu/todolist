class Todo {
  String id;
  String title;
  String description;
  DateTime date;
  bool isDone = false;

  Todo({this.id, this.title, this.description, this.date});

  Todo.fromMap(Map map)
      : this.id = map['id'],
        this.title = map["title"],
        this.description = map["description"],
        this.date = map["date"];

  Map toMap() {
    return {
      'title': this.title,
      'description': this.description,
      'date': this.date.toIso8601String(),
    };
  }
}
