class Todo {
  const Todo({
    required this.id,
    required this.name,
    required this.description,
    required this.priority,
  });

  final int id;
  final String name;
  final String description;
  final int priority;

  Todo copyWith({
    int? id,
    String? name,
    String? description,
    int? priority,
  }) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      priority: priority ?? this.priority,
    );
  }

  static Todo fromJson(Map<String, Object?> json) {
    return Todo(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      priority: json['priority'] as int,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'priority': priority,
    };
  }
}
