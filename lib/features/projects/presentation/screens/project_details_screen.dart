import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../tasks/presentation/ cubit/task_cubit.dart';
import '../../../tasks/presentation/ cubit/task_state.dart';
import '../../domain/entities/project.dart';
import '../../../tasks/presentation/Widgets/add_task_bottom_sheet.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailsScreen({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<TaskCubit>()
          ..loadTasks(project.id),
        child: Builder(
            builder: (context) {
              return Scaffold(
      appBar: AppBar(
        title: Text(project.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(project.description),

            const SizedBox(height: 12),

            Text(
              "Status: ${project.status}",
            ),

            const SizedBox(height: 24),

            const Divider(),

            const Text(
              "Tasks",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is TaskError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  if (state is TaskLoaded) {
                    if (state.tasks.isEmpty) {
                      return const Center(
                        child: Text("No Tasks Found"),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];

                        return Card(
                          child:
                          ListTile(
                            title: Text(task.title),
                            subtitle: Text(
                              "${task.status} • ${task.priority}",
                            ),
                            trailing: Checkbox(
                              value: task.status == "Done",
                              onChanged: task.status == "Done"
                                  ? null
                                  : (_) {
                                context.read<TaskCubit>().markTaskAsDone(
                                  taskId: task.id,
                                  projectId: project.id,
                                );
                              },
                            ),

                          )
                        );
                      },
                    );
                  }

                  return const SizedBox();


                },

              ),
            ),
          ],
        ),

      ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (bottomSheetContext) {
                  return BlocProvider.value(
                    value: context.read<TaskCubit>(),
                    child: AddTaskBottomSheet(
                      projectId: project.id,
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),      );
            },
        ),
    );
  }
}