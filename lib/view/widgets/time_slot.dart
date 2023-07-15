import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:taxverse/api/api_const.dart';
import 'package:taxverse/utils/constant/constants.dart';
import 'package:taxverse/view/Appoinments/timeslot.dart';

class TimeSlotAppoinment extends StatefulWidget {
  TimeSlotAppoinment({Key? key}) : super(key: key);

  @override
  State<TimeSlotAppoinment> createState() => _TimeSlotAppoinmentState();
}

class _TimeSlotAppoinmentState extends State<TimeSlotAppoinment> {
  List<TimeSlot> timeslot = [
    TimeSlot(time: '09:00 AM', isTaken: false),
    TimeSlot(time: '10:00 AM', isTaken: false),
    TimeSlot(time: '11:00 AM', isTaken: false),
    TimeSlot(time: '12:00 PM', isTaken: false),
    TimeSlot(time: '01:00 PM', isTaken: false),
    TimeSlot(time: '02:00 PM', isTaken: false),
    TimeSlot(time: '03:00 PM', isTaken: false),
    TimeSlot(time: '04:00 PM', isTaken: false),
    TimeSlot(time: '05:00 PM', isTaken: false),
  ];

  @override
  Widget build(BuildContext context) {
    int rowCount = (timeslot.length / 3).ceil();

    return Column(
      children: List.generate(rowCount, (index) {
        int startIndex = index * 3;
        int endIndex = (index + 1) * 3;

        List<TimeSlot> rowSlots = timeslot.sublist(startIndex, endIndex);
        return Row(
          children: rowSlots.map((slot) {
            final bool isSelected = selectedTime == slot.time;

            return SizedBox(
              width: 20.w,
              child: RawChip(
                labelPadding: EdgeInsets.zero,
                label: Text(
                  slot.time,
                  textAlign: TextAlign.left,
                  style: isSelected
                      ? TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        )
                      : TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                ),
                backgroundColor: isSelected ? blackColor : Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 1.sp,
                  ),
                  borderRadius: BorderRadius.circular(5.sp),
                ),
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      selectedTime = slot.time;
                      log(selectedTime);
                    } else {
                      selectedTime = '';
                    }
                  });
                },
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
