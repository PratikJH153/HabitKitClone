import 'package:flutter/material.dart';
import 'package:habittracker/views/home.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeID:
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Page not found"),
            ),
          ),
        );
    }
  }
}
