import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift; // Alias to avoid conflicts
import '../database/database.dart';
import '../providers/database_provider.dart';

// Changed from StatefulWidget to ConsumerStatefulWidget
class SystemScreen extends ConsumerStatefulWidget {
  const SystemScreen({super.key});

  @override
  ConsumerState<SystemScreen> createState() => _SystemScreenState();
}

class _SystemScreenState extends ConsumerState<SystemScreen> {
  // LOGIC: Toggle the quest status in the Database
  void _toggleQuest(Quest quest) {
    final database = ref.read(databaseProvider);

    final newStatus = !quest.isCompleted;
    final newCurrent = newStatus ? quest.target : 0;

    // Create a copy of the quest with updated fields
    final updatedQuest = quest.copyWith(
      isCompleted: newStatus,
      current: newCurrent,
    );

    database.updateQuest(updatedQuest);
  }

  // LOGIC: Add a dummy quest for testing (We will remove this later)
  void _addDebugQuest() {
    final database = ref.read(databaseProvider);
    final companion = QuestsCompanion(
      title: const drift.Value("NEW QUEST"),
      target: const drift.Value(10),
      current: const drift.Value(0),
      isCompleted: const drift.Value(false),
    );
    database.addQuest(companion);
  }

  // LOGIC: Delete a quest (Long press to delete)
  void _deleteQuest(Quest quest) {
    ref.read(databaseProvider).deleteQuest(quest);
  }

  @override
  Widget build(BuildContext context) {
    // Watch the database stream
    final database = ref.watch(databaseProvider);
    final stream = database.watchAllQuests();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addDebugQuest,
        backgroundColor: const Color(0xFF2196F3),
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 600, // Made it taller
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF001E36).withOpacity(0.95),
            border: Border.all(color: const Color(0xFF2196F3), width: 2),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2196F3).withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "QUEST INFO",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(color: Color(0xFF2196F3), thickness: 1),
              const SizedBox(height: 20),

              const Text(
                "DAILY QUEST",
                style: TextStyle(
                  color: Color(0xFF2196F3),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "PREPARE FOR THE TRUTH",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // THE REACTIVE LIST
              Expanded(
                child: StreamBuilder<List<Quest>>(
                  stream: stream,
                  builder: (context, snapshot) {
                    // 1. Loading State
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // 2. Error State
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    // 3. Data State
                    final quests = snapshot.data ?? [];

                    if (quests.isEmpty) {
                      return const Center(
                        child: Text(
                          "NO QUESTS ACTIVE",
                          style: TextStyle(color: Colors.white30),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: quests.length,
                      itemBuilder: (context, index) {
                        final quest = quests[index];
                        return GestureDetector(
                          onTap: () => _toggleQuest(quest),
                          onLongPress: () => _deleteQuest(quest),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  quest.isCompleted
                                      ? "[ X ]  ${quest.title}"
                                      : "[   ]  ${quest.title}",
                                  style: TextStyle(
                                    color: quest.isCompleted
                                        ? Colors.white
                                        : Colors.white70,
                                    fontSize: 18,
                                    decoration: quest.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    decorationColor: const Color(0xFF2196F3),
                                    decorationThickness: 2,
                                  ),
                                ),
                                Text(
                                  "${quest.current} / ${quest.target}",
                                  style: TextStyle(
                                    color: quest.isCompleted
                                        ? const Color(0xFF2196F3)
                                        : Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
