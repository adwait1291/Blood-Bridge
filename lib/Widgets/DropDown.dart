import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDown extends StatefulWidget {
  Function dropDownHandler;
  var text;
  final List<String> items;

  DropDown({
    required this.items,
    required this.dropDownHandler,
    required this.text,
  });
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    var selectedValue = widget.items[0];
    widget.dropDownHandler(selectedValue);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        color: Color(0xFFF9DEE4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          value: selectedValue,
          hint: Text(widget.text, style: TextStyle(color: Colors.black54)),
          items: widget.items.map(
            (String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: TextStyle(color: Colors.black54),
                ),
              );
            },
          ).toList(),
          dropdownMaxHeight: 200.h,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          onChanged: (val) {
            setState(
              () {
                selectedValue = val.toString();
                widget.dropDownHandler(selectedValue);
              },
            );
          },
        ),
      ),
    );
  }
}
