import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/projects/data/datasources/local/project_local_data_source.dart';
import '../../features/projects/data/datasources/project_remote_data_source.dart';
import '../../features/projects/data/datasources/project_remote_data_source_impl.dart';
import '../../features/projects/data/repositories/project_repository_impl.dart';
import '../../features/projects/domain/repositories/project_repository.dart';
import '../../features/projects/domain/usecases/get_projects_usecase.dart';
import '../../features/projects/presentation/cubit/project_cubit.dart';
import '../../features/tasks/data/datasources/task_remote_data_source.dart';
import '../../features/tasks/data/datasources/task_remote_data_sourceImpl.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/tasks/domain/repositories/taskRepository.dart';
import '../../features/tasks/domain/usecases/add_task_use_case.dart';
import '../../features/tasks/domain/usecases/get_tasks_use_case.dart';
import '../../features/tasks/domain/usecases/mark_task_done_use_case.dart';
import '../../features/tasks/presentation/ cubit/task_cubit.dart';
import '../network/dio_client.dart';
import '../storage/shared_pref_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {

  // Dio
  getIt.registerLazySingleton<DioClient>(
        () => DioClient(),
  );

  // Remote Data Source
  getIt.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
      getIt<DioClient>(),
    ),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
    ),
  );

  // Login UseCase
  getIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(
      getIt<AuthRepository>(),
    ),
  );

  // Register UseCase
  getIt.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(
      getIt<AuthRepository>(),
    ),
  );

  // Cubit
  getIt.registerFactory<AuthCubit>(
        () => AuthCubit(
      getIt<LoginUseCase>(),
      getIt<RegisterUseCase>(),
      getIt<SharedPrefService>(),
    ),
  );

   // shared_preferences
  getIt.registerLazySingleton<SharedPrefService>(
        () => SharedPrefService(),
  );


   // projects
  // Projects Data Source
  getIt.registerLazySingleton<ProjectRemoteDataSource>(
        () => ProjectRemoteDataSourceImpl(
      getIt<DioClient>(),
    ),
  );

// Projects Repository
  getIt.registerLazySingleton<ProjectRepository>(
        () => ProjectRepositoryImpl(
      getIt<ProjectRemoteDataSource>(),
      getIt<ProjectLocalDataSource>(),
    ),
  );
// Projects UseCase
  getIt.registerLazySingleton<GetProjectsUseCase>(
        () => GetProjectsUseCase(
      getIt<ProjectRepository>(),
    ),
  );

// Projects Cubit
  getIt.registerFactory<ProjectCubit>(
        () => ProjectCubit(
      getIt<GetProjectsUseCase>(),
    ),
  );

   // projects local cache
  getIt.registerLazySingleton<ProjectLocalDataSource>(
        () => ProjectLocalDataSource(),
  );
  // tasks datasource
  getIt.registerLazySingleton<TaskRemoteDataSource>(
        () => TaskRemoteDataSourceImpl(getIt()),
  );

  //tasks repository
  getIt.registerLazySingleton<TaskRepository>(
        () => TaskRepositoryImpl(getIt()),
  );
  //tasks get & add & done useCase
  getIt.registerLazySingleton(
        () => GetTasksUseCase(getIt()),
  );
  getIt.registerLazySingleton(
        () => AddTaskUseCase(getIt()),
  );

  getIt.registerLazySingleton(
        () => MarkTaskDoneUseCase(getIt()),
  );
  // tasks cubit
  getIt.registerFactory(
        () => TaskCubit(
      getIt(),
      getIt(),
          getIt(),
    ),
  );


}