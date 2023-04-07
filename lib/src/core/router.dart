import 'package:go_router/go_router.dart';
import 'package:project32/src/presentation/screens/home_screen.dart';
import 'package:project32/src/presentation/screens/movies_details_screen.dart';
import 'package:project32/src/presentation/screens/search_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: "/",
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: 'movies',
          path: "movies/:id",
          builder: (context, state) => MovieDetailsScreen(
            id: int.parse(state.params['id']!),
          ),
        ),
        GoRoute(
          name: 'search',
          path: "search",
          builder: (context, state) => const SearchScreen(),
        ),
      ],
    ),
  ],
);
