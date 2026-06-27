import 'package:dio/dio.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';



class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(DioClient client)
      : dio = client.dio;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.get(
      ApiConstants.users,
      queryParameters: {
        'email': 'eq.$email',
        'password': 'eq.$password',
      },
    );

    final users = (response.data as List)
        .map((e) => UserModel.fromJson(e))
        .toList();

    if (users.isEmpty) {
      throw Exception("Invalid email or password");
    }

    return users.first;
  }
  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await dio.post(
      ApiConstants.users,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "token": DateTime.now().millisecondsSinceEpoch.toString(),
      },
    );
  }
}