import '../../domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.projectId,
    required super.title,
    required super.status,
    required super.priority,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      projectId: json['project_id'].toString(),
      title: json['title'],
      status: json['status'],
      priority: json['priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "project_id": int.parse(projectId),
      "title": title,
      "status": status,
      "priority": priority,
    };
  }
}