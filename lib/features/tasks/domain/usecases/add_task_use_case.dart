import '../repositories/taskRepository.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<void> call({
    required String projectId,
    required String title,
    required String status,
    required String priority,
  }) {
    return repository.addTask(
      projectId: projectId,
      title: title,
      status: status,
      priority: priority,
    );
  }
}