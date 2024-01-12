import 'package:habittracker/logic/database.dart';
import 'package:habittracker/logic/habit_abstract.dart';
import 'package:habittracker/models/habit.dart';

class HabitManager implements HabitManagerAbs {
  final DatabaseService _db = DatabaseService.instance;

  @override
  Future<List<Habit>> getAllHabits() async {
    final List<Habit> habits = await _db.getHabitLists();

    return habits;
  }

  @override
  Future<bool> deleteHabit(int habitID) async {
    final result = await _db.deleteHabit(habitID);

    if (result != null) {
      return true;
    }

    return false;
  }

  @override
  Future<bool> insertHabit(Habit habit) async {
    final int id = await _db.insertHabit(habit);

    if (id >= 0) {
      return true;
    }

    return false;
  }

  @override
  Future<bool> updateHabit(Habit habit) async {
    final result = await _db.updateHabit(habit);

    if (result != null) {
      return true;
    }

    return false;
  }
}
