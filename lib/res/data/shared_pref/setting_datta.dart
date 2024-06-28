import 'package:shared_preferences/shared_preferences.dart';

class SettingData{
  static const String _switchKey = 'switchKey';
  static const String _duration  = 'duration';
  static const String _screen  = 'screenType';
  static const String _pageLength  = 'pageLength';
  // Save most played song limit
  Future<void> setSwitchValue({required bool activate, required String timeFormat, required String screenType}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_switchKey, activate);
    await prefs.setString(_duration, timeFormat);
    await prefs.setString(_screen, screenType);
  }
  Future<void> setSwitchOnly({required bool activate, }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_switchKey, activate);
  }

  Future<void> setPageLength({required int pageLength, }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_pageLength, pageLength);
  }
  Future<int> getPageLength() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     return  prefs.getInt(_pageLength)??0 ;
  }

  // Get most played song limit
  Future<(bool, String, String)> getSwitchValue() async {  // switch, time, screen
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.getBool(_switchKey)??false, prefs.getString(_duration)??'24h', prefs.getString(_screen)??'home') ;
  }
}

