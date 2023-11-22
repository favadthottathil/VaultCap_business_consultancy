import 'package:flutter/material.dart';
import 'package:vaultcap/view/widgets/check_permission.dart';


class DashBoardProvider extends ChangeNotifier {
  bool isPermission = false;

  bool showSuccess = false;

  String? path;

  double? progress;

  var checkAllPermission = CheckPermission();
  int currentStep = 0;

  int temp = 0;

  downloadedCompleted() {
    progress = null;
    showSuccess = true;
    notifyListeners();
  }

  setProgressValue(double value) {
    progress = value;
    notifyListeners();
  }

  countinueStep() {
    if (currentStep < temp) {
      currentStep = currentStep + 1;
      notifyListeners();
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      currentStep = currentStep - 1;
      notifyListeners();
    }
  }

  onStepTapped(int value) {
    if (value <= temp) {
      currentStep = value;
      notifyListeners();
    }
  }

  checkPermission() async {
    var permission = await checkAllPermission.isStoragePermission();

    if (permission) {
      isPermission = true;
      notifyListeners();
    }
  }
}
