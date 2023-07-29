import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:exp_app/utils/utils.dart';

class ChartPieFlayer extends StatefulWidget {
  const ChartPieFlayer({super.key});

  @override
  State<ChartPieFlayer> createState() => _ChartPieFlayerState();
}

class _ChartPieFlayerState extends State<ChartPieFlayer> {

  int _index = 0;
  bool _animation = true;

  @override
  Widget build(BuildContext context) {
    var gList = context.watch<ExpensesProvider>().groupItemsList;
    double totalOthers = 0.0;

    if(_index >= gList.length) {
      _index = 0;
    }
    if (gList.length >= 6) {
      totalOthers = gList.sublist(5).map((e) => e.amount).fold(0.0, (a, b) => a + b);
      gList = gList.sublist(0,5).toList();
      gList.add(CombinedModel(
        category: '0tros',
        amount: totalOthers,
        icon: 'otros',
        color: '#a1a1a1'
      ));
    }
    var item = gList[_index];
    List<charts.Series<CombinedModel, String>> _series(int index) {
      return [
        charts.Series<CombinedModel, String>(
          id: 'PieChart',
          domainFn: (v, i) => v.category,
          measureFn: (v, i) => v.amount,
          data: gList,
          keyFn: (v, i) => v.icon,
          //cambia los colores del elemento seleccionado de la grafica
          colorFn: (v, i) {
            var onTap = i == index;
            if (onTap == false) {
              return charts.ColorUtil.fromDartColor(v.color.toColor());
            } else {
              return charts.ColorUtil.fromDartColor(v.color.toColor()).darker;
            }
          },
        ),
      ];
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        charts.PieChart<String>(
          _series(_index),
          animate: _animation,
          animationDuration: const Duration(
            milliseconds: 500
          ),
          //activa las interacciones con la grafica
          defaultInteractions: true,
          //Diseño de la grafica
          defaultRenderer: charts.ArcRendererConfig(
            //genera un hueco dependiendo del porcentaje que le pasemos
            arcWidth: 25,
            //grosor de la linea divisora
            strokeWidthPx: 0.1,
          ),
          selectionModels: [
            charts.SelectionModelConfig(
              //redibujando, icons, Categorias y Gastos
              type: charts.SelectionModelType.info,
              changedListener: (charts.SelectionModel model) {
                if (model.hasDatumSelection) {
                  setState(() {
                    _animation = false;
                    _index = model.selectedDatum[0].index!;
                  });
                }
              },
            )
          ],
        ),
        SizedBox(
          width: 55.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Icon(
                  item.icon.toIcon(),
                  color: item.color.toColor(),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(item.category),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(getAmountFormat(item.amount)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
