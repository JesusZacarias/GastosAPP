import 'package:flutter/cupertino.dart';

class Constants {
  static sheetBoxDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
    );
  }

  static customButtom(Color decoarationC, Color borderC, String _text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: decoarationC,
          border: Border.all(
            color: borderC,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Text(
            _text,
          ),
        ),
      ),
    );
  }
}


           