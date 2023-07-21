import 'package:exp_app/utils/icon_List.dart';
import 'package:flutter/material.dart';
export 'package:exp_app/utils/utils.dart';

int daysInMonth(int month) {
  var now = DateTime.now();
  var lastDay = (month < 12)
  ? DateTime(now.year, month + 1, 0)
  : DateTime(now.year + 1, 1, 0);
  return lastDay.day;
}
extension ColorExtension on String {

  toColor() {
    String hexcolor = replaceAll('#', '');
    if(hexcolor.length == 6) {

      // hexcolor = 'FF' + hexcolor;
      // so iguales
      hexcolor = 'FF$hexcolor';
    }

    if(hexcolor.length == 8){ 
      return Color(int.parse('0x$hexcolor'));
    }
  }
}


extension IconExtension on String {
  toIcon() {
    return IconList().iconMap[this];
  }
}