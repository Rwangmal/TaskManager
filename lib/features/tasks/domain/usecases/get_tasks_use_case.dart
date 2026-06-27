import '../entities/task.dart';
import '../repositories/taskRepository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<Task>> call(String projectId) {
    return repository.getTasks(projectId);
  }
}