import 'package:cinechase/src/domain/supabase_repository/supabase_auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

final authStatusProvider = Provider(
  (ref) => AuthStatus(
    service: ref.watch(supabaseAuthProvider),
  ),
);

class AuthStatus {
  final SupabaseAuthService _service;

  AuthStatus({required SupabaseAuthService service}) : _service = service;

  bool isLoggedIn() {
    bool result = false;
    _service.authSubscription().listen(
      (event) {
        AuthChangeEvent data = event.event;
        if (data == AuthChangeEvent.signedIn) {
          result = true;
        }
        if (data == AuthChangeEvent.signedOut) {
          result = false;
        }
      },
    );
    return result;
  }
}
