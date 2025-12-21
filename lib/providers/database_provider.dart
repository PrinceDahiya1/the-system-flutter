import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';

// This is a global variable that holds our database.
// 'Provider' tells Riverpod: "Here is a piece of data that doesn't change."
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
