import 'package:exp_app/models/expenses_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class ChartLine extends StatelessWidget {
  const ChartLine({super.key});

  @override
  Widget build(BuildContext context) {
    var eList = context.watch<ExpensesProvider>().eList;
    var currentMonth = context.watch<UIProvider>().selectedMonth + 1;

    List<ExpensesModel> eModel = [];
    Map<int, dynamic> mapExp;
    List<double> perDayList;

    //Ejempo con Map
    mapExp = eList.fold({},(Map<int, dynamic> map, exp){
      if(!map.containsKey(exp.day)){
        map[exp.day] = 0.0;
      }
      map[exp.day] += exp.expenses;
      return map;
    });
    mapExp.forEach((key, value) { 
      eModel.add(ExpensesModel(
        day: key,
        expenses: value
      ));
    });
   // eList.sort((a, b) => a.day.compareTo(b.day));//ordenar por dia
   eModel.add(ExpensesModel(day: 0, expenses: 0.0));
   eModel.sort((a,b) => a.day.compareTo(b.day));
    List<charts.Series<ExpensesModel, num>> series = [
      charts.Series<ExpensesModel, num>(
        id: 'ExpensesPerDay',
        //datos de abajo horizontal
        domainFn: (v,i) => v.day,
        //datos que estan en la parte vertical
        measureFn: (v,i) => v.expenses,
        data: eModel
      )
    ];

    //Ejemplo con double
    var current = daysInMonth(currentMonth);
    
    perDayList = List.generate(current + 1, (int i) {
      return eList
      .where((e) => e.day == (i))
      .map((e) => e.expenses)
      .fold(0.0, (a, b) => a +b);
    });
    List<charts.Series<double, int>> series2 = [
      charts.Series<double, int>(
        id: 'ExpensesPerDay',
        //datos de abajo horizontal
        //i = Dias
        domainFn: (v,i) => i!,
        //datos que estan en la parte vertical
        //v = Gastos
        measureFn: (v,i) => v,
        data: perDayList,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.cyan),
        radiusPxFn: (v,i) {
          if(v == 0.0){
            return 0;
          }
          return 4;
        }
      )
    ];
    //
    return SizedBox(
      child: charts.LineChart(
        series2,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(
          includePoints: true,
          includeArea: true,
          areaOpacity: 0.2
        ),
      ),
    );
  }
}