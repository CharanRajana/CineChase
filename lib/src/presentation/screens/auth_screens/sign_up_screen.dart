import 'package:cinechase/src/presentation/screens/auth_screens/components/custom_button.dart';
import 'package:cinechase/src/presentation/screens/auth_screens/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../repository/supabase_repository/supabase_auth_service.dart';
import '../scaffold_with_bottom_nav_bar/scaffold_with_bottom_nav_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
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
                    'SignUp',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid Username';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
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
                      text: 'Sign Up',
                      onPressed: () {
                        final auth = ref.watch(supabaseAuthProvider);

                        if (_formKey.currentState!.validate()) {
                          auth.signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            username: usernameController.text,
                          );

                          if (mounted) {
                            Navigator.of(context, rootNavigator: true).push(
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
                      'Already have an account?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(' Login from here',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
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
