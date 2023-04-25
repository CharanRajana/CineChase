import 'package:cinechase/src/core/theme.dart';
import 'package:cinechase/src/presentation/screens/scaffold_with_bottom_nav_bar/scaffold_with_bottom_nav_bar.dart';
import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    DevicePreview(
      tools: const [
        ...DevicePreview.defaultTools,
        DevicePreviewScreenshot(),
      ],
      enabled: !kReleaseMode,
      builder: (context) => const ProviderScope(
        child: Application(),
      ),
    ),
  );
}

class Application extends ConsumerWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Group project',
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const ScaffoldWithBottomNavBar(),
    );
  }
}
