import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
 Future<bool> isStoragePermission() async {
    var isStorage = await Permission.storage.status;
    var isAccesLc = await Permission.accessMediaLocation.status;
    var isMnagExt = await Permission.manageExternalStorage.status;

    if (!isStorage.isGranted || !isAccesLc.isGranted || !isMnagExt.isGranted) {
      await Permission.storage.request();
      await Permission.accessMediaLocation.request();
      await Permission.manageExternalStorage.request();
      if (!isStorage.isGranted || !isAccesLc.isGranted || !isMnagExt.isGranted) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
