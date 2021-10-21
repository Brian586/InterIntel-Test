class TodoItem {
  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  TodoItem({this.userId, this.id, this.title, this.completed});

  factory TodoItem.fromJson(Map<String, dynamic> jsonData) {
    return TodoItem(
      userId: jsonData["userId"],
      id: jsonData["id"],
      title: jsonData["title"],
      completed: jsonData["completed"],
    );
  }
}