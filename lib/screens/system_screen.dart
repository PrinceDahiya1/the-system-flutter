import 'package:flutter/material.dart';
import '../models/quest.dart';

class SystemScreen extends StatefulWidget {
  const SystemScreen({super.key});

  @override
  State<SystemScreen> createState() => _SystemScreenState();
}

class _SystemScreenState extends State<SystemScreen> {
  // 1. The Data (State)
  final List<Quest> quests = [
    Quest(title: "PUSH-UPS", target: 100),
    Quest(title: "CURL-UPS", target: 100),
    Quest(title: "SQUATS", target: 100),
    Quest(title: "RUNNING", target: 10, unit: "km"),
  ];

  // 2. The Logic (Controller)
  void _toggleQuest(int index) {
    setState(() {
      // Toggle completion status
      quests[index].isCompleted = !quests[index].isCompleted;

      // If completed, set current to target. If unchecked, reset to 0.
      if (quests[index].isCompleted) {
        quests[index].current = quests[index].target;
      } else {
        quests[index].current = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // Window Dimensions
          width: 350,
          height: 550,
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

              // 3. The List Builder (Dynamic Rendering)
              Expanded(
                child: ListView.builder(
                  itemCount: quests.length,
                  itemBuilder: (context, index) {
                    final quest = quests[index];
                    return GestureDetector(
                      onTap: () =>
                          _toggleQuest(index), // Connects the tap to logic
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),
                        color: Colors.transparent, // Required for tap target
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              // Change icon based on state
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
                              quest.progressString,
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
                ),
              ),

              const Text(
                "WARNING: Failure to complete this quest will result in a penalty.",
                style: TextStyle(color: Colors.redAccent, fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
