import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_task_use_case.dart';
import '../../domain/usecases/get_tasks_use_case.dart';
import '../../domain/usecases/mark_task_done_use_case.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final MarkTaskDoneUseCase markTaskDoneUseCase;
  TaskCubit(
      this.getTasksUseCase,
      this.addTaskUseCase,
      this.markTaskDoneUseCase,
      ) : super(TaskInitial());

  Future<void> loadTasks(String projectId) async {
    emit(TaskLoading());

    try {
      final tasks = await getTasksUseCase(projectId);

      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> addTask({
    required String projectId,
    required String title,
    required String status,
    required String priority,
  }) async {
    try {
      await addTaskUseCase(
        projectId: projectId,
        title: title,
        status: status,
        priority: priority,
      );

      await loadTasks(projectId);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> markTaskAsDone({
    required String taskId,
    required String projectId,
  }) async {
    try {
      await markTaskDoneUseCase(taskId);

      await loadTasks(projectId);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}