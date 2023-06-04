import 'package:cinechase/src/core/theme.dart';
import 'package:cinechase/src/presentation/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/common/async_value_widget.dart';
import 'src/presentation/screens/auth_screens/sign_up_screen.dart';
import 'src/repository/auth_repository/controller/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
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
    final user = ref.watch(currentUserProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group project',
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: AsyncValueWidget(
        value: user,
        data: (user) {
          if (user != null) {
            return const HomeScreen();
          }
          return const SignUpScreen();
        },
      ),
    );
  }
}
