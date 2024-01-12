import 'package:flutter/cupertino.dart';
import 'package:habittracker/models/habit.dart';

List<Habit> habits = [
  Habit(
    title: "Meditation",
    description: "Description",
    color: const Color(0xFFb39ddb),
    icon: CupertinoIcons.bolt_horizontal,
    done: [0, 1, 2, 3, 4, 10, 15],
  ),
  Habit(
    title: "Exercise",
    description: "Description",
    color: const Color(0xFF9ccc65),
    icon: CupertinoIcons.archivebox_fill,
    done: [],
  ),
  Habit(
    title: "Reading",
    description: "Description",
    color: const Color(0xFFff5252),
    icon: CupertinoIcons.book,
    done: [],
  ),
];
