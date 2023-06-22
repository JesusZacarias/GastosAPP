import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class FrontSheet extends StatelessWidget {
  const FrontSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var _list = List.generate(
      10,
      (i) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 150.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );

    return Container(
      // height: 850.0,
      decoration: Constants.sheetBoxDecoration(
          Theme.of(context).scaffoldBackgroundColor,
        ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: _list,
      ),
    );
  }
}
