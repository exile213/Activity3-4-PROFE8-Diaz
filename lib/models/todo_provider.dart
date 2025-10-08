import 'package:flutter/material.dart';

/// Todo item for flight preparation checklist
class TodoItem {
  final String id;
  String title;
  String description;
  bool isCompleted;
  Priority priority;
  DateTime createdAt;

  TodoItem({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.priority = Priority.medium,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  TodoItem copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    Priority? priority,
    DateTime? createdAt,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'priority': priority.index,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TodoItem.fromMap(Map<String, dynamic> map) {
    return TodoItem(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'],
      priority: Priority.values[map['priority']],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

enum Priority { low, medium, high, critical }

extension PriorityExtension on Priority {
  String get name {
    switch (this) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
      case Priority.critical:
        return 'Critical';
    }
  }

  Color get color {
    switch (this) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.orange;
      case Priority.high:
        return Colors.red;
      case Priority.critical:
        return Colors.deepPurple;
    }
  }
}

/// Provider for managing flight preparation todos
class TodoProvider extends ChangeNotifier {
  final List<TodoItem> _todos = [
    TodoItem(
      id: '1',
      title: 'Weather Check',
      description: 'Check wind speed, precipitation, and visibility conditions',
      priority: Priority.critical,
    ),
    TodoItem(
      id: '2',
      title: 'Battery Inspection',
      description: 'Ensure all batteries are fully charged and functioning',
      priority: Priority.high,
    ),
    TodoItem(
      id: '3',
      title: 'Flight Path Planning',
      description: 'Plan optimal flight route and identify no-fly zones',
      priority: Priority.high,
    ),
    TodoItem(
      id: '4',
      title: 'Equipment Calibration',
      description: 'Calibrate gimbal, compass, and GPS systems',
      priority: Priority.medium,
    ),
    TodoItem(
      id: '5',
      title: 'Backup Landing Sites',
      description: 'Identify and mark emergency landing locations',
      priority: Priority.medium,
    ),
  ];

  List<TodoItem> get allTodos => List.unmodifiable(_todos);

  List<TodoItem> get completedTodos =>
      _todos.where((todo) => todo.isCompleted).toList();

  List<TodoItem> get incompleteTodos =>
      _todos.where((todo) => !todo.isCompleted).toList();

  int get totalTodos => _todos.length;
  int get completedCount => completedTodos.length;
  int get incompleteCount => incompleteTodos.length;

  double get completionPercentage =>
      totalTodos > 0 ? (completedCount / totalTodos) * 100 : 0;

  /// Add a new todo item
  void addTodo(
    String title,
    String description, {
    Priority priority = Priority.medium,
  }) {
    final newTodo = TodoItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      priority: priority,
    );
    _todos.add(newTodo);
    notifyListeners();
  }

  /// Toggle todo completion status
  void toggleTodo(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
      );
      notifyListeners();
    }
  }

  /// Update todo details
  void updateTodo(
    String id, {
    String? title,
    String? description,
    Priority? priority,
  }) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(
        title: title,
        description: description,
        priority: priority,
      );
      notifyListeners();
    }
  }

  /// Delete a todo item
  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  /// Clear all completed todos
  void clearCompleted() {
    _todos.removeWhere((todo) => todo.isCompleted);
    notifyListeners();
  }

  /// Get todos by priority
  List<TodoItem> getTodosByPriority(Priority priority) {
    return _todos.where((todo) => todo.priority == priority).toList();
  }

  /// Mark all todos as completed (for demonstration)
  void completeAll() {
    for (int i = 0; i < _todos.length; i++) {
      _todos[i] = _todos[i].copyWith(isCompleted: true);
    }
    notifyListeners();
  }

  /// Reset all todos to incomplete (for demonstration)
  void resetAll() {
    for (int i = 0; i < _todos.length; i++) {
      _todos[i] = _todos[i].copyWith(isCompleted: false);
    }
    notifyListeners();
  }
}
