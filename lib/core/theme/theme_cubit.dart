import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di/injection_container.dart';
import '../storage/shared_pref_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPrefService sharedPrefService = getIt<SharedPrefService>();

  ThemeCubit() : super(ThemeMode.light) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    final isDark = await sharedPrefService.getTheme();

    emit(
      isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }

  Future<void> toggleTheme() async {
    final isDark = state == ThemeMode.light;

    await sharedPrefService.saveTheme(isDark);

    emit(
      isDark ? ThemeMode.dark : ThemeMode.light,
    );
  }
}