import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker({Key? key, this.selectedDate}) : super(key: key);
  late DateTime? selectedDate;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker(
      initialDate: widget.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      onDateChanged: (value) {
        // _selectedDate = value;
        if (widget.selectedDate != null && value != widget.selectedDate) {
          setState(() {
            widget.selectedDate = value;
          });
        }
      },
    );
  }
}
