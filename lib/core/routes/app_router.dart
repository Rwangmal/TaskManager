import 'package:go_router/go_router.dart';

import 'package:task_manager_app/features/auth/presentation/screens/login_screen.dart';
import 'package:task_manager_app/features/auth/presentation/screens/register_screen.dart';
import 'package:task_manager_app/features/auth/presentation/screens/splash_screen.dart';

import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/projects/domain/entities/project.dart';
import '../../features/projects/presentation/screens/project_details_screen.dart';
import '../../features/projects/presentation/screens/projects_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/projects',
      builder: (context, state) => const ProjectsScreen(),
    ),
    GoRoute(
      path: '/project-details',
      builder: (context, state) {
        final project = state.extra as Project;

        return ProjectDetailsScreen(
          project: project,
        );
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);