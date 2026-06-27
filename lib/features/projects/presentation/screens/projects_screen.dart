import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection_container.dart';
import '../cubit/project_cubit.dart';
import '../cubit/project_state.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {

  late final ProjectCubit cubit;

  @override
  void initState() {
    super.initState();

    cubit = getIt<ProjectCubit>();

    cubit.getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Projects'),
          actions: [
            IconButton(
              onPressed: () {
                context.push('/profile');
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
        body: BlocBuilder<ProjectCubit, ProjectState>(
          builder: (context, state) {

            if (state is ProjectLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ProjectError) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is ProjectLoaded) {

              if (state.projects.isEmpty) {
                return const Center(
                  child: Text('No Projects Found'),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await cubit.getProjects();
                },
                child: ListView.builder(
                  itemCount: state.projects.length,
                  itemBuilder: (context, index) {

                    final project = state.projects[index];

                    return ListTile(
                      title: Text(project.title),
                      subtitle: Text(project.description),
                      trailing: Text(project.status),
                      onTap: () {
                        context.push(
                          '/project-details',
                          extra: project,
                        );
                      },
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}