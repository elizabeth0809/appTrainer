import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_app/domain/provider/userProvider.dart';
import 'package:trainer_app/presentation/screens/registerScreen.dart';
import 'package:trainer_app/presentation/screens/screen.dart';

final router = Provider<GoRouter>((ref) {
  // Escuchamos el userProvider para que el router se reconstruya cuando cambie
  final userState = ref.watch(userProvider);
   return GoRouter(
    initialLocation: '/',
    refreshListenable: ValueNotifier(userState),
    redirect: (context, state) {
    final user = ref.read(userProvider);
    final isLoggingIn = state.matchedLocation == '/';

    if (user == null) {
        return isLoggingIn ? null : '/';
      }
    if (isLoggingIn) {
        return user.data.role == 'admin' ? '/admin' : '/home';
      }
   if (state.matchedLocation == '/admin' && user.data.role != 'admin') {
        return '/home';
      }

    return null;
  },
routes: [
    GoRoute(path: '/', builder: (_, __) => LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => RegisterScreen()),

    GoRoute(path: '/forget', builder: (context, state) => const ForgetScreen()),

    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    GoRoute(path: '/admin', builder: (_, __) => AdminScreen()),
    GoRoute(path: '/home', builder: (_, __) => HomeScreen()),
    GoRoute(path: '/permissions',builder: (context, state) => const PermissionsScreen(), ),
    GoRoute(path: '/usersScheduling',builder: (context, state) => SchedulingUsersScreen(), ),
    GoRoute(path: '/reports',builder: (context, state) => ReportsScreen(), ),
    GoRoute(
      path: '/scheduling',
      builder: (context, state) => ExercisesScreen(),
    ),
    GoRoute(
      path: '/homeExercise',
      builder: (context, state) {
        return ExercisesScreen();
      },
      routes: [
        GoRoute(path: '/exercise',builder: (context, state) => ExerciseFormScreen(),),
        GoRoute(
          path: '/confirm',
          builder: (context, state) => const ConfirmScreen(),
        ),
      ],
    ),
  ],
   );
});
