import 'package:go_router/go_router.dart';
import 'package:trainer_app/presentation/screens/screen.dart';



final router = GoRouter(
  routes: [
    
    //! General
    GoRoute(
      path: '/',
      builder: (context, state) => LoginScreen(),
    ),

    GoRoute(
      path: '/forget',
      builder: (context, state) => const Forgetscreen(),
    ),
    /*
    GoRoute(
      path: '/collection',
      builder: (context, state) => (),
    ),
    GoRoute(
      path: '/recipes',
      builder: (context, state) => const (),
    ),

    GoRoute(
      path: '/books',
      builder: (context, state) => const (),
    ),
    GoRoute(
      path: '/permissions',
      builder: (context, state) => const (),
    ),*/


]);