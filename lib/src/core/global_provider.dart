import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingProvider = StateProvider.autoDispose<double>((ref) => 0);

final isFavouriteProvider = StateProvider<bool>((ref) => false);
