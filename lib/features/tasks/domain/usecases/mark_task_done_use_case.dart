import '../repositories/taskRepository.dart';

class MarkTaskDoneUseCase {
  final TaskRepository repository;

  MarkTaskDoneUseCase(this.repository);

  Future<void> call(String taskId) {
    return repository.markTaskAsDone(taskId);
  }
}