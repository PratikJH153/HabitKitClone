import 'package:habittracker/models/habit.dart';

abstract class HabitManagerAbs {
  Future<List<Habit>> getAllHabits();
  Future<bool> insertHabit(Habit habit);
  Future<bool> updateHabit(Habit habit);
  Future<bool> deleteHabit(int habitID);
}
