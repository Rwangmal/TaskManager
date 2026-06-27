import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/shared_pref_service.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final SharedPrefService sharedPrefService;
  AuthCubit(
      this.loginUseCase,
      this.registerUseCase,  this.sharedPrefService,
      ) : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final user = await loginUseCase(
        email: email,
        password: password,
      );
      await sharedPrefService.saveToken(user.token);

      await sharedPrefService.saveUser(
        id: user.id,
        name: user.name,
        email: user.email,
      );

      emit(AuthSuccess("Login Success"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await registerUseCase(
        name: name,
        email: email,
        password: password,
      );

      emit(AuthSuccess("Registration Success"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}