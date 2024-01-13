import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habittracker/constants/add_content.dart';
import 'package:habittracker/logic/habit_impl.dart';
import 'package:habittracker/models/habit.dart';
import 'package:habittracker/views/add_page.dart';
import 'package:habittracker/widgets/custom_dialog_box.dart';
import 'package:habittracker/widgets/dialog_box_widget.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  static const routeID = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = false;
  int indexExpanded = -1;
  int offset = 0;
  List<Habit>? habits;

  final HabitManager _habitManager = HabitManager();

  void expand(int index) {
    setState(() {
      isExpanded = !isExpanded;
      if (indexExpanded == -1) {
        indexExpanded = index;
      } else {
        indexExpanded = -1;
      }
    });
  }

  void addStreakInSql(Habit habit) async {
    final bool result = await _habitManager.updateHabit(habit);
    //TODO: SHOW SOMETHING
    if (result) {
    } else {}
  }

  void addStreak(
    Habit habit,
    int todayPointer,
  ) {
    setState(() {
      if (habit.done!.contains(todayPointer)) {
        habit.done!.remove(todayPointer);
      } else {
        habit.done!.add(todayPointer);
      }
      addStreakInSql(habit);
    });
  }

  void getHabits() async {
    final List<Habit> temp = await _habitManager.getAllHabits();
    setState(() {
      habits = temp;
    });
  }

  void updateOffset() {}

  @override
  void initState() {
    getHabits();

    super.initState();
  }

  void goToAddPage({Habit? habit}) async {
    final result = await showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      showDragHandle: true,
      builder: (context) {
        return AddPage(
          habit: habit,
        );
      },
    );
    if (result) {
      getHabits();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToAddPage(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.white,
        child: const Icon(CupertinoIcons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Habit",
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "Kit",
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 150, 143, 255),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.celebration_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bar_chart_rounded),
          ),
        ],
      ),
      body: habits == null
          ? const Center(child: CircularProgressIndicator())
          : habits!.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "assets/images/search.json",
                        height: 200,
                        width: 200,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "You have not made Habits yet!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "Get your life sorted! By clicking the add button below!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      bottom: 120,
                      top: 20,
                      left: 18,
                      right: 18,
                    ),
                    itemCount: habits!.length,
                    itemBuilder: (ctx, index) {
                      final Habit habit = habits![index];

                      final int todayPointer = DateTime.now()
                          .difference(DateTime.parse(habit.startDate!))
                          .inDays;

                      return GestureDetector(
                        onTap: () => expand(index),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 39, 39, 39),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 5),
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 0.1,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: habitColors[habit.color],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: habitIcons[habit.icon],
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    habit.title!,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      isExpanded && indexExpanded == index
                                          ? expand(index)
                                          : addStreak(habit, todayPointer);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: habitColors[habit.color]!
                                            .withOpacity(0.3),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child:
                                          isExpanded && indexExpanded == index
                                              ? const Icon(Icons.close)
                                              : const Icon(Icons.done),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 100,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 28, // Number of columns
                                    crossAxisSpacing:
                                        2.0, // Spacing between columns
                                    mainAxisSpacing:
                                        2.0, // Spacing between rows
                                  ),
                                  itemCount: 7 * 28,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    //TODO: Make it reverse
                                    int reversedIndex = index + (offset * 28);

                                    return Container(
                                      decoration: BoxDecoration(
                                        color:
                                            habit.done!.contains(reversedIndex)
                                                ? habitColors[habit.color]!
                                                : habitColors[habit.color]!
                                                    .withOpacity(0.1),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          ' ',
                                          style: TextStyle(
                                              color: Colors.transparent),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              isExpanded && indexExpanded == index
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        habit.description!.isNotEmpty
                                            ? Text(
                                                habit.description!,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 249, 249, 249),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () => addStreak(
                                                    habit, todayPointer),
                                                icon: const Icon(
                                                  Icons.done_all,
                                                  color: Colors.black,
                                                ),
                                                label: const Text(
                                                  "Complete",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: habitColors[habit.color]!
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: IconButton(
                                                onPressed: () =>
                                                    goToAddPage(habit: habit),
                                                icon: const Icon(
                                                    CupertinoIcons.pencil),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: habitColors[habit.color]!
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  showCustomDialog(
                                                    context,
                                                    DialogBoxWidget(
                                                      title: "Delete the habit",
                                                      des:
                                                          "Are you sure want to delete the habit?",
                                                      firstButton: "Yes",
                                                      secondButton: "Cancel",
                                                      firstOnTap: () {
                                                        _habitManager
                                                            .deleteHabit(
                                                                habit.id!);
                                                        setState(() {
                                                          getHabits();
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      secondOnTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(
                                                    CupertinoIcons.delete),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
