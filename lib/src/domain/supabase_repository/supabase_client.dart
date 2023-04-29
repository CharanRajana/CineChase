import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import '../../core/constants.dart';

final supabaseClientProvider = Provider(
  (ref) => SupabaseClient(
    Constants.supabaseUrl,
    Constants.supabaseKey,
  ),
);
