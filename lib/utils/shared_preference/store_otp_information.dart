import 'package:shared_preferences/shared_preferences.dart';

class OtpSharedPreferece {
  static storeVerificatinId(String verificationId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('verificationId', verificationId);
  }

  static   getVerificationId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String verificatioinId = sharedPreferences.getString('verificationId') ?? 'error';
    print(verificatioinId);
    return verificatioinId;
  }

  static storeOtp(String otp) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('otp', otp);
  }

  static  getOtp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String otp = sharedPreferences.getString('otp') ?? '';
    print(otp);
    return otp;
  }
}
