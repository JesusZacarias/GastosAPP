import 'package:flutter/material.dart';

class FlayerSkin extends StatelessWidget {
  final String myTitle;
  final Widget myWidget;
  const FlayerSkin({super.key, required this.myTitle, required this.myWidget});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left:14.0, right: 14.0, bottom: 40.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 14.0,
              bottom: 8.0,
            ),
            width: size.width,
            child: Text(
              myTitle,
              style: const TextStyle(
                fontSize: 18.0,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: myWidget,
    
          ),
        ],
      ),
    );
  }
}
