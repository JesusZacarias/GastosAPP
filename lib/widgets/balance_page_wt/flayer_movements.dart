import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/widgets/global_tw/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class FlayerMovements extends StatelessWidget {
  const FlayerMovements({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final entList = context.watch<ExpensesProvider>().enList;
    double _totalExp = 0;
    double _totalEnt = 0;
    
    _totalExp = getSumOfExp(eList);
    _totalEnt = getSumOfEntrie(entList);
    /*Para controlar que el porsentaje no exceda del 100
    Pero se controlo directamente desde el diseño del grafico*/
    // bool porMayo1 = false;
    // double _masGasto = _totalExp / _totalEnt;
    // if (_masGasto >= 1) {
    //   porMayo1 = true;
    // }

    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: PercIndicCircular(
              // percent: (porMayo1) ? 1 : _masGasto,
              // color: (porMayo1) ? Colors.red : Colors.green,
              percent: _totalExp / _totalEnt,
              color: Colors.green,
              radius: 80.0,
              arcType: ArcType.FULL,
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 150.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gastos Realizados',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2),
                    ),
                    Text(
                      getAmountFormat(_totalExp),
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2),
                    ),
                    Text('Absorbe un ${(_totalExp / _totalEnt * 100).toStringAsFixed(2)}% de tus ingresos',
                    style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
