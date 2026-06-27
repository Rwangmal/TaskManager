import '../../domain/entities/task.dart';
import '../../domain/repositories/taskRepository.dart';
import '../datasources/task_remote_data_source.dart';


class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Task>> getTasks(String projectId) {
    return remoteDataSource.getTasks(projectId);
  }

  @override
  Future<void> addTask({
    required String projectId,
    required String title,
    required String status,
    required String priority,
  }) {
    return remoteDataSource.addTask(
      projectId: projectId,
      title: title,
      status: status,
      priority: priority,
    );
  }

  @override
  Future<void> markTaskAsDone(String taskId) {
    return remoteDataSource.markTaskAsDone(taskId);
  }
}