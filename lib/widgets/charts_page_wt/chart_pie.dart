import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:exp_app/utils/utils.dart';

class ChartPie extends StatefulWidget {
  const ChartPie({super.key});

  @override
  State<ChartPie> createState() => _ChartPieState();
}

class _ChartPieState extends State<ChartPie> {
  String catName = 'Total';
  String catColor = '#ff00ff';
  String catIcon = 'attach_money_outlined';
  double catAmount = 0.0;
  double expTotal = 0.0;
  int _index = -1;
  bool _animation = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catAmount = context.read<ExpensesProvider>().eList
    .map((e) => e.expenses).fold(0.0, (a, b) => a + b);
    expTotal = context.read<ExpensesProvider>().eList
    .map((e) => e.expenses).fold(0.0, (a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    final gList = context.watch<ExpensesProvider>().groupItemsList;
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
          //muestra los datos en los labels
          labelAccessorFn: (v, i) =>
              '${(v.amount * 100 / expTotal).toStringAsFixed(2)}%',
          //Cambia el tamaño de los labels
          outsideLabelStyleAccessorFn: (v, i) {
            var onTap = i == index;
            return charts.TextStyleSpec(
              fontSize: (onTap) ? 14 : 8,
              color:  charts.ColorUtil.fromDartColor(Theme.of(context).dividerColor),
            );
          }
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
            arcWidth: 45,
            //grosor de la linea divisora
            strokeWidthPx: 0.1,
            arcRendererDecorators: [
              //Coloca en labels
              charts.ArcLabelDecorator(
                //posiciona los labels por fuera
                labelPosition: charts.ArcLabelPosition.outside,
                labelPadding: 2,
                //oculta las lineas punteadas indicadoras cuando esta en false
                showLeaderLines: true,
                leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                    length: 15,
                    color: charts.MaterialPalette.white,
                    //grosor de la linea indicadora
                    thickness: 1),
                //decora los labes que se encuentran fuera de la grafica
                outsideLabelStyleSpec: const charts.TextStyleSpec(
                    color: charts.MaterialPalette.white, fontSize: 10),
                //para editar los labels que esten dentro de la grafica
                // insideLabelStyleSpec:
              ),
            ],
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
                    catIcon = model
                        .selectedSeries[0].keyFn!(model.selectedDatum[0].index)
                        .toString();
                    catName = model.selectedSeries[0]
                        .domainFn(model.selectedDatum[0].index)
                        .toString();
                    catAmount = model.selectedSeries[0]
                        .measureFn(model.selectedDatum[0].index)!
                        .toDouble();
                    catColor = model.selectedSeries[0]
                        .colorFn!(model.selectedDatum[0].index)
                        //Remplasa las ff por '' a partir de la posicion 6
                        .toString()
                        .replaceFirst(RegExp(r'ff'), '', 6);
                  });
                }
              },
            )
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Icon(
                catIcon.toIcon(),
                color: catColor.toColor(),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(catName),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(getAmountFormat(catAmount)),
            ),
          ],
        )
      ],
    );
  }
}
