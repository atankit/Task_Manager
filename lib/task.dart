class Task {
  final int? id;
  final String title;
  final String description;
  final String dueDate;
  late final bool completed;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate,
      'completed': completed ? true : false,
    };
  }
}
