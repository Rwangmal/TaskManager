import 'package:dio/dio.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/TaskModel.dart';

import 'TaskRemoteDataSource.dart';


class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Dio dio;

  TaskRemoteDataSourceImpl(DioClient client) : dio = client.dio;

  @override
  Future<List<TaskModel>> getTasks(String projectId) async {
    final response = await dio.get(
      ApiConstants.tasks,
      queryParameters: {
        "project_id": "eq.$projectId",
      },
    );

    return (response.data as List)
        .map((e) => TaskModel.fromJson(e))
        .toList();
  }

  @override
  Future<void> addTask({
    required String projectId,
    required String title,
    required String status,
    required String priority,
  }) async {
    await dio.post(
      ApiConstants.tasks,
      data: {
        "project_id": int.parse(projectId),
        "title": title,
        "status": status,
        "priority": priority,
      },
    );
  }

  @override
  Future<void> markTaskAsDone(String taskId) async {
    await dio.patch(
      ApiConstants.tasks,
      queryParameters: {
        "id": "eq.$taskId",
      },
      data: {
        "status": "Done",
      },
    );
  }
}