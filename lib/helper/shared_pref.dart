import 'package:shared_preferences/shared_preferences.dart';

class RowOffset {
  static Future<void> setInt(int row) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('offset', row);
  }

  static Future<int?> getInt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('offset');
  }
}
