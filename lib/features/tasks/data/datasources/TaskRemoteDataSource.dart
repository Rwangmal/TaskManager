import '../models/TaskModel.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks(String projectId);

  Future<void> addTask({
    required String projectId,
    required String title,
    required String status,
    required String priority,
  });
  Future<void> markTaskAsDone(String taskId);
}