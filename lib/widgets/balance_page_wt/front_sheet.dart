import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/widgets/balance_page_wt/flayer_balance.dart';
import 'package:exp_app/widgets/balance_page_wt/flayer_categories.dart';
import 'package:exp_app/widgets/balance_page_wt/flayer_frecuency.dart';
import 'package:exp_app/widgets/balance_page_wt/flayer_movements.dart';
import 'package:exp_app/widgets/balance_page_wt/flayer_skin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class FrontSheet extends StatelessWidget {
  const FrontSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    bool hasData = false;

    if (eList.isNotEmpty) {
      hasData = true;
    }

    return Container(
      // height: 850.0,
      decoration: Constants.sheetBoxDecoration(
        Theme.of(context).scaffoldBackgroundColor,
      ),
      child: (hasData)
          ? ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children:  [
                const FlayerSkin(
                    myTitle: "Categoria de Gastos",
                    myWidget: FlayersCategories()),
                const FlayerSkin(
                  myTitle: "Frecuencia de Gastos",
                  myWidget: FlayerFreciency()
                ),
                const FlayerSkin(
                  myTitle: "Movimientos",
                  myWidget: FlayerMovements()
                ),
                const FlayerSkin(
                  myTitle: "Balance General",
                  myWidget: FlayerBalance()
                ),
                Container(
                  padding: const EdgeInsets.all(30.0),
                  // child: Image.asset('assets/Empty.png'),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset('assets/Empty.png'),
                ),
                const Text(
                  'Sin Gastos este mes',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.3,
                  ),
                ),
              ],
            ),
    );
  }
}
