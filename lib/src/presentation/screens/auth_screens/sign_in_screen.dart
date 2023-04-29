import 'package:cinechase/src/domain/supabase_repository/supabase_auth_service.dart';
import 'package:cinechase/src/presentation/screens/auth_screens/components/custom_button.dart';
import 'package:cinechase/src/presentation/screens/auth_screens/sign_up_screen.dart';
import 'package:cinechase/src/presentation/screens/scaffold_with_bottom_nav_bar/scaffold_with_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Text(
                    'SignIn',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 6) {
                      return 'Username must be at least 6 characters in length';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Consumer(
                  builder: (context, ref, child) {
                    return CustomButton(
                      text: 'Sign In',
                      onPressed: () {
                        final auth = ref.watch(supabaseAuthProvider);

                        if (_formKey.currentState!.validate()) {
                          auth.signIn(
                              email: emailController.text,
                              password: passwordController.text);
                          if (mounted) {
                            Navigator.of(
                              context,
                              rootNavigator: true,
                            ).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ScaffoldWithBottomNavBar(),
                              ),
                            );
                          }
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      ),
                      child: Text(
                        ' Create an Account',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
