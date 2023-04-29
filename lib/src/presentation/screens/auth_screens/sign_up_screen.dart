import 'package:cinechase/src/presentation/screens/auth_screens/components/custom_button.dart';
import 'package:cinechase/src/presentation/screens/auth_screens/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CustomButton(
                text: 'Sign Up',
                onPressed: () {},
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
