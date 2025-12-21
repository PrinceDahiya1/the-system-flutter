class Quest {
  String title;
  int current;
  int target;
  String unit; // e.g., "km", "reps"
  bool isCompleted;

  Quest({
    required this.title,
    required this.target,
    this.current = 0,
    this.unit = "reps",
    this.isCompleted = false,
  });

  // A helper to show progress string like "5/10 reps"
  String get progressString => "$current / $target $unit";
}
