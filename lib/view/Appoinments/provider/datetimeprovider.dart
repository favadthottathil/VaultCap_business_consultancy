import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeProvider extends ChangeNotifier {
  setDateAndTime(BuildContext context, TextEditingController businessStartDate) async {
    DateTime? pickdate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickdate != null) {
      businessStartDate.text = DateFormat('yyyy-MM-dd').format(pickdate);
      notifyListeners();
    }
  }
}
