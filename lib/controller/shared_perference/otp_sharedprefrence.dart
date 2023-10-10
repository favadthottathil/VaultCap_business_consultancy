import 'package:shared_preferences/shared_preferences.dart';

class OtpSharedPreference {
  storePhoneNumberToSharedPreference(String phoneNumber) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    await sharedPreference.setString('phone', phoneNumber);
  }

  getOtpSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return  sharedPreferences.getString('phone');
  }
}
