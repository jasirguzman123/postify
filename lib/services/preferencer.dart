import 'package:shared_preferences/shared_preferences.dart';

class Preferencer{

  static Future<String> getUsersData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('data');
  }

  static Future<bool> setUsersData(data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('data', data);
  }
}