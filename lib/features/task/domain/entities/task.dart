class UserTask {

  final String id;
  final String title;
  final String description;
  final DateTime dueDate;  // Changed to DateTime
  final String priority;

  UserTask({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,  // Accept DateTime
    required this.priority,
  });

  factory UserTask.fromMap(Map<dynamic, dynamic> map, String id) {

    return UserTask(
      id: id,
      title: map['title'],
      description: map['description'],
      dueDate: DateTime.parse(map['dueDate']),  // Parse the timestamp into DateTime
      priority: map['priority'],
    );

  }

  Map<String, dynamic> toMap() {

    return {
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),  // Store as ISO8601 string or timestamp
      'priority': priority,
    };

  }


  // copyWith method to allow modification of fields in the object
  UserTask copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? priority,
  }) {
    return UserTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
    );
  }

}
