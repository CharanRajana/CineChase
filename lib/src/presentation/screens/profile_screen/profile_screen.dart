import 'package:cinechase/src/common/custom_button.dart';
import 'package:cinechase/src/presentation/screens/profile_screen/components/pie_chart.dart';
import 'package:cinechase/src/presentation/screens/profile_screen/components/user_card.dart';
import 'package:cinechase/src/repository/auth_repository/controller/auth_controller.dart';
import 'package:cinechase/src/repository/database_repository/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/bar_graph.dart';

class ProfileScreen extends ConsumerWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      );
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userControllerProvider);
    final data = user.ratings.values.toList().cast<double>();
    final Map<String, double> data1 = {
      "Sci-Fi": 4.25,
      "Adventure": 3.51,
      "Comedy": 2.83,
      "Horror": 6.9,
    }; // Sample data
    final session = ref.read(authControllerProvider.notifier);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              UserCard(
                name: user.name.toUpperCase(),
                email: user.email,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: BarGraph(data: data),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: PieChartCard(data: data1),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onPressed: () {
                  session.signOut(context: context);
                },
                text: "Sign Out",
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
