import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Quests extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 3, max: 32)();
  IntColumn get target => integer()();
  IntColumn get current => integer()();
  BoolColumn get isCompleted => boolean()();
}

@DriftDatabase(tables: [Quests])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'quests_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }

  // 1. READ: Watch all quests (Reactive)
  // Returns a Stream that emits a new list whenever the table changes.
  Stream<List<Quest>> watchAllQuests() {
    return (select(
      quests,
    )..orderBy([(t) => OrderingTerm(expression: t.id)])).watch();
  }

  // 2. CREATE: Add a new quest
  // We use 'QuestsCompanion' because the ID is auto-increment (we don't set it).
  Future<int> addQuest(QuestsCompanion entry) {
    return into(quests).insert(entry);
  }

  // 3. UPDATE: Toggle status or edit details
  // Takes a full 'Quest' object (which already has an ID).
  Future<bool> updateQuest(Quest quest) {
    return update(quests).replace(quest);
  }

  // 4. DELETE: Remove a quest
  Future<int> deleteQuest(Quest quest) {
    return delete(quests).delete(quest);
  }
}
