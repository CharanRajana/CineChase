import 'package:cinechase/src/domain/supabase_repository/supabase_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

final supabaseAuthProvider = Provider(
  (ref) => SupabaseAuthService(
    ref.watch(
      supabaseClientProvider,
    ),
  ),
);

class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class SignInWithEmailAndPasswordFailure implements Exception {
  const SignInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const SignInWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class SignOutFailure implements Exception {}

class SupabaseAuthService {
  final SupabaseClient _supabaseClient;

  SupabaseAuthService(this._supabaseClient);

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (error) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(error.message);
    } on Exception {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
    } on AuthException catch (error) {
      throw SignInWithEmailAndPasswordFailure.fromCode(error.message);
    } on Exception {
      throw const SignInWithEmailAndPasswordFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } on AuthException {
      throw SignOutFailure();
    }
  }

  Stream<AuthState> authSubscription() {
    return _supabaseClient.auth.onAuthStateChange;
  }
}
