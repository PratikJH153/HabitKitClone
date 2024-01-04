import "package:flutter/material.dart";
import "package:habittracker/routes/routes.dart";
import "package:habittracker/views/home.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Habit Tracker",
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Raleway",
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: "Raleway",
        colorScheme: const ColorScheme.dark(
          background: Color.fromARGB(255, 26, 26, 26),
          primary: Color(0xFF4942E4),
          secondary: Color.fromARGB(255, 121, 112, 247),
        ),
      ),
      initialRoute: HomePage.routeID,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
