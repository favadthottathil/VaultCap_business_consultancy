import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';

class RegisterPhoneProvider extends ChangeNotifier {
  setValueToPhoneController(String controller, String value) {
    controller = value;
    notifyListeners();
  }

  setValueToCountry(Country country, Country value) {
    country = value;
    notifyListeners();
  }
}
