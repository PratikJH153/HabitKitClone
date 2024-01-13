import 'package:habittracker/helper/capitalize_text.dart';

class Habit {
  int? id;
  int? icon;
  String? title;
  String? description;
  List? done;
  int? color;
  String? startDate;

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

  @override
  String toString() {
    return 'Habit: {id: $id, title: $title, description: $description, icon: $icon, color: $color, done: $done, startDate: $startDate}';
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;

    map['description'] = description.toString();
    map['icon'] = icon;
    map['color'] = color;
    map['done'] = done!.join(" ");
    map['startDate'] = startDate;

    return map;
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit.withID(
      id: map['id'],
      title: map['title'].toString().capitalize(),
      description: map['description'].toString().capitalize(),
      icon: map['icon'],
      color: map['color'],
      done: map["done"] != null && map["done"].toString().trim().isNotEmpty
          ? map["done"]
              ?.split(" ")
              .map((String number) => int.parse(number))
              .toList()
          : [],
      startDate: map["startDate"],
    );
  }
}
