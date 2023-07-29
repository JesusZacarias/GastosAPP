import 'package:charts_flutter/flutter.dart' as charts;
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ChartBar extends StatelessWidget {
  const ChartBar({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final entList = context.watch<ExpensesProvider>().enList;
    double totalExp = 0;
    double totalEnt = 0;
    totalExp =  getSumOfExp(eList);
    totalEnt = getSumOfEntrie(entList);
    final data = [
      OrdinalSale('Ingresos', totalEnt, Colors.green),
      OrdinalSale('Gastos', totalExp, Colors.red)
    ];
    

    List<charts.Series<OrdinalSale, String>> seriesList = [
      charts.Series<OrdinalSale, String>(
        id: 'Balance',
        domainFn: (v, i) => v.name,
        measureFn: (v, i) => v.amount,
        colorFn: (v, i) => charts.ColorUtil.fromDartColor(v.color),
        data: data
      )
    ];
    return SizedBox(
      child: charts.BarChart(
        seriesList,
        defaultRenderer: charts.BarRendererConfig(
          //tamaño de lo redondeado e la punta
          cornerStrategy: const charts.ConstCornerStrategy(
            5,
          ),
        ),
        primaryMeasureAxis: const charts.NumericAxisSpec(
          //para eliminar lineas horizontales
          renderSpec: charts.NoneRenderSpec(),
        ),
      ),
    );
  }
}

class OrdinalSale {
  String name;
  double amount;
  Color color;

  OrdinalSale(this.name, this.amount, this.color);
}