import 'package:flutter_task/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSharedPreference {
  void loggedIn() async {
    final sharedPreference = await SharedPreferences.getInstance();
   await sharedPreference.setBool(isLogged, true);
  }

  void logOut() async {
      final sharedPreference = await SharedPreferences.getInstance();
   await sharedPreference.setBool(isLogged, false);
  }
}
