import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongo_dart/mongo_dart.dart';

final ratingProvider = StateProvider.autoDispose<double>((ref) => 0);

final isFavouriteProvider = StateProvider<bool>((ref) => false);

final databaseProvider = Provider<Db>(
  (ref) => throw Exception('Unexpected Error initializing MongoDb'),
);
