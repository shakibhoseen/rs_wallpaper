import 'package:shared_preferences/shared_preferences.dart';

class SettingData{
  static const String _switchKey = 'switchKey';

  // Save most played song limit
  Future<void> setSwitchValue({required bool activate}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_switchKey, activate);
  }

  // Get most played song limit
  Future<bool> getSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_switchKey)??false ;
  }
}