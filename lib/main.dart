import 'package:cinechase/src/core/constants.dart';
import 'package:cinechase/src/core/theme.dart';
import 'package:cinechase/src/domain/supabase_repository/auth_status.dart';
import 'package:cinechase/src/presentation/screens/auth_screens/sign_in_screen.dart';
import 'package:cinechase/src/presentation/screens/scaffold_with_bottom_nav_bar/scaffold_with_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseKey,
  );

  runApp(
    const ProviderScope(
      child: Application(),
    ),
  );
}

class Application extends ConsumerWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authStatusProvider).isLoggedIn();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group project',
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home:
          isLoggedIn ? const ScaffoldWithBottomNavBar() : const SignInScreen(),
    );
  }
}
