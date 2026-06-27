import 'package:dio/dio.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/project_model.dart';
import 'project_remote_data_source.dart';

class ProjectRemoteDataSourceImpl
    implements ProjectRemoteDataSource {

  final Dio dio;

  ProjectRemoteDataSourceImpl(DioClient client)
      : dio = client.dio;

  @override
  Future<List<ProjectModel>> getProjects() async {
    final response = await dio.get(
      ApiConstants.projects,
    );
    print(response.data);
    return (response.data as List)
        .map(
          (e) => ProjectModel.fromJson(e),
    )
        .toList();
  }
}