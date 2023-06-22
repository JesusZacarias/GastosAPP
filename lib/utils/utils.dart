import 'package:exp_app/utils/icon_List.dart';
import 'package:flutter/material.dart';

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