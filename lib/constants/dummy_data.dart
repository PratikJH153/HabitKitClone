import 'package:habittracker/models/habit.dart';

List<Habit> habits = [
  Habit(
    title: "Meditation",
    description: "Description",
    color: 3,
    icon: 3,
    done: [1, 5, 6],
    startDate:
        DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
  ),
  Habit(
    title: "Exercise",
    description: "Description",
    color: 6,
    icon: 1,
    done: [1, 5, 6],
    startDate:
        DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
  ),
  Habit(
    title: "Reading",
    description: "Description",
    color: 9,
    icon: 8,
    done: [1, 5, 6],
    startDate:
        DateTime.now().subtract(const Duration(days: 0)).toIso8601String(),
  ),
];
