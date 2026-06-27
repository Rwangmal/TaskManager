import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../datasources/local/project_local_data_source.dart';
import '../datasources/project_remote_data_source.dart';
import '../models/project_model.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;
  final ProjectLocalDataSource localDataSource;

  ProjectRepositoryImpl(
      this.remoteDataSource,
      this.localDataSource,
      );

  @override
  Future<List<Project>> getProjects() async {
    try {
      final projects = await remoteDataSource.getProjects();
      await localDataSource.cacheProjects(projects);


      return projects;
    } catch (_) {
      return localDataSource.getCachedProjects();
    }
  }
}