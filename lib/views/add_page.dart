import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/constants/add_content.dart';
import 'package:habittracker/logic/habit_impl.dart';
import 'package:habittracker/models/habit.dart';
import 'package:habittracker/widgets/textfield_widget.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  Color _selectedColor = const Color(0xFFef9a9a);
  Icon _selectedIcon = const Icon(
    CupertinoIcons.star,
    size: 28,
  );

  final HabitManager _habitManager = HabitManager();

  void addHabit() async {
    if (_nameController.text.trim().isNotEmpty) {
      int colorIndex = 0;
      int habitIndex = 0;

      habitColors.forEach((key, value) {
        if (value == _selectedColor) {
          colorIndex = key;
        }
      });
      habitIcons.forEach((key, value) {
        if (value.icon == _selectedIcon.icon) {
          habitIndex = key;
        }
      });

      final Habit habit = Habit(
        title: _nameController.text,
        description: _desController.text.trim(),
        color: colorIndex,
        done: [],
        icon: habitIndex,
        startDate: DateTime.now().toIso8601String(),
      );

      final bool result = await _habitManager.insertHabit(habit);

      if (result) {
        print("ADDED");
      } else {
        print("NOT ADDED!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: addHabit,
        child: Container(
          height: 60,
          width: double.infinity,
          margin: const EdgeInsets.only(
            bottom: 20,
            left: 20,
            right: 20,
          ),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: const Text(
              "Add Habit",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
                fontFamily: "Grandis Extended",
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text(
          "New Habit",
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: addHabit,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWidget(
              title: "Name",
              controller: _nameController,
            ),
            TextFieldWidget(
              title: "Description",
              controller: _desController,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Icon",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 150,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemCount: habitIcons.values.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIcon = habitIcons.values.toList()[index];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: _selectedIcon.icon ==
                                      habitIcons.values.toList()[index].icon
                                  ? Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    )
                                  : null,
                              color: const Color.fromARGB(255, 45, 45, 45),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: habitIcons.values.toList()[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Color",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 140,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                        mainAxisSpacing: 12.0,
                        crossAxisSpacing: 12.0,
                      ),
                      itemCount: habitColors.values.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor =
                                  habitColors.values.toList()[index];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: habitColors.values.toList()[index],
                            ),
                            child: Center(
                              child: _selectedColor ==
                                      habitColors.values.toList()[index]
                                  ? Container(
                                      height: 18,
                                      width: 18,
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
