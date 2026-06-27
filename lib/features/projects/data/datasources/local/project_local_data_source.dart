

import 'package:hive/hive.dart';

import '../../models/project_model.dart';




class ProjectLocalDataSource {
  final Box box = Hive.box('projects');

  Future<void> cacheProjects(List<ProjectModel> projects) async {
    await box.put(
      'projects',
      projects.map((e) => e.toJson()).toList(),
    );
  }

  List<ProjectModel> getCachedProjects() {
    final data = box.get('projects');

    if (data == null) return [];

    return (data as List)
        .map(
          (e) => ProjectModel.fromJson(
        Map<String, dynamic>.from(e),
      ),
    )
        .toList();
  }

  Future<void> clearCache() async {
    await box.clear();
  }
}