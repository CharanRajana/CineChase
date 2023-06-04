import 'package:cinechase/src/core/snackbar.dart';
import 'package:cinechase/src/presentation/screens/auth_screens/sign_in_screen.dart';
import 'package:cinechase/src/presentation/screens/home_screen/home_screen.dart';
import 'package:cinechase/src/repository/auth_repository/auth_service.dart';
import 'package:appwrite/models.dart' as model;
import 'package:cinechase/src/repository/database_repository/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = FutureProvider((ref) {
  final controller = ref.watch(authControllerProvider.notifier);
  return controller.currentUser();
});

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    ref,
    auth: ref.watch(authenticationProvider),
  ),
);

class AuthController extends StateNotifier<bool> {
  final Ref ref;
  final Authentication _auth;
  AuthController(this.ref, {required Authentication auth})
      : _auth = auth,
        super(false);

  Future<model.User?> currentUser() => _auth.currentUserAccount();

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _auth.signUp(
        email: email, password: password, name: email.split('@').first);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        ref.read(userControllerProvider.notifier).updateUserData(
              id: r.$id,
              email: email,
            );
        showSnackBar(context, 'Account created successfully, Please Login');
        Navigator.push(context, SignInScreen.route());
      },
    );
  }

  void signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _auth.signIn(email: email, password: password);
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        ref.read(userControllerProvider.notifier).updateUserData(
              id: r.userId,
              email: email,
            );
        Navigator.push(context, HomeScreen.route());
      },
    );
  }

  void signOut({
    required BuildContext context,
  }) async {
    state = true;
    final res = await _auth.logOut();
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        Navigator.pushAndRemoveUntil(
          context,
          SignInScreen.route(),
          (route) => false,
        );
      },
    );
  }
}
