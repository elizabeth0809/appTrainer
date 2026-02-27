import 'package:go_router/go_router.dart';
import 'package:trainer_app/presentation/screens/registerScreen.dart';
import 'package:trainer_app/presentation/screens/screen.dart';

final router = GoRouter(
  routes: [
    //! General
    GoRoute(path: '/', builder: (context, state) => LoginScreen()),

    GoRoute(path: '/forget', builder: (context, state) => const ForgetScreen()),

    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/editInfo ',
      builder: (context, state) => const EditInfoScreen(),
    ),

    GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionsScreen(),
    ),
    GoRoute(
      path: '/scheduling',
      builder: (context, state) => ExercisesScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return HomeScreen();
      },
      routes: [
        GoRoute(
          path: '/editInfoId',
          builder: (context, state) => const SchedulingCreateScreen(),
        ),
        GoRoute(
          path: '/exercise',
          builder: (context, state) => ExerciseFormScreen(),
        ),
        GoRoute(
          path: '/confirm',
          builder: (context, state) => const ConfirmScreen(),
        ),
      ],
    ),
  ],
);
