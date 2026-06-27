import '../entities/task.dart';
abstract class TaskRepository {
  Future<List<Task>> getTasks(String projectId);

  Future<void> addTask({
    required String projectId,
    required String title,
    required String status,
    required String priority,
  });
  Future<void> markTaskAsDone(String taskId);
}