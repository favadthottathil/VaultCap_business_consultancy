import 'package:flutter/material.dart';

class UserAccountProvider extends ChangeNotifier {
  Map<String, UserEdit> userEdit = {
    'Name': UserEdit(),
    'phoneNumber': UserEdit(),
    'address': UserEdit(),
    'place': UserEdit(),
  };

  setShowEditTrueName() {
    userEdit['Name']?.showEdit = true;
    notifyListeners();
  }

  setShowEditTruephone() {
    userEdit['phoneNumber']?.showEdit = true;
    notifyListeners();
  }

  setShowEditTrueAddress() {
    userEdit['address']?.showEdit = true;
    notifyListeners();
  }

  setShowEditTruePlace() {
    userEdit['place']?.showEdit = true;
    notifyListeners();
  }

  setShowEditFalse(String mapName) {
    userEdit[mapName]?.showEdit = false;
    notifyListeners();
  }
}

class UserEdit {
  bool showEdit = false;
}
