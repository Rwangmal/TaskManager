import 'package:task_manager_app/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> register({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> login({
    required String email,
    required String password,
  });
}