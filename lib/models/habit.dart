import 'package:flutter/cupertino.dart';

class Habit {
  int? id;
  IconData? icon;
  String? title;
  String? description;
  List<int>? done;
  Color? color;
  DateTime? startDate;

  Habit({
    this.title,
    this.description,
    this.icon,
    this.color,
    this.done,
    this.startDate,
  });

  Habit.withID({
    this.id,
    this.title,
    this.description,
    this.icon,
    this.color,
    this.done,
    this.startDate,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;

    map['description'] = description;
    map['icon'] = icon;
    map['color'] = color;
    map['done'] = done;
    map['startDate'] = startDate;

    return map;
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit.withID(
      id: map['id'],
      title: map['title'],
      description: map['priority'],
      icon: map['icon'],
      color: map['color'],
      done: map["done"],
      startDate: map["startDate"],
    );
  }
}
