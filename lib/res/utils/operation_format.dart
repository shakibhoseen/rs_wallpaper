class OperationFormat{

 static (Duration, String) getValueGenerate(String val) {
    switch (val) {
      case '15m':
        return (const Duration(minutes: 15), '15 Minutes');
      case '30m':
        return (const Duration(minutes: 15), '30 Minutes');
      case '1h':
        return (const Duration(hours: 1), '1 Hour');
      case '5h':
        return (const Duration(hours: 5), '5 Hour');
      case '10h':
        return (const Duration(hours: 10), '10 Hour');
      default:
        return (const Duration(hours: 24), '24 Hour');
    }
  }

  static String getScreenNameFromBool({required bool home,required bool lock}){
    if(home && lock){
      return 'Both Screen';
    }else if(lock){
      return 'Lock Screen';
    }
    return 'Home Screen';
  }

 static String getFullScreenNameFromString({required String screenType,}){
   if(screenType == 'both'){
     return 'Both Screen';
   }else if(screenType == 'lock'){
     return 'Lock Screen';
   }
   return 'Home Screen';
 }

 static (bool, bool) getBooleanFromScreenFormat({required String screenType,}){
   if(screenType == 'both'){
     return (true, true);
   }else if(screenType == 'lock'){
     return (false, true);
   }
   return (true, false);
 }

}