import 'package:exp_app/models/expenses_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart' as element;
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ChartLine extends StatelessWidget {
  static String? pointAmount;
  static String? pointDay;
  const ChartLine({super.key});

  @override
  Widget build(BuildContext context) {
    var eList = context.watch<ExpensesProvider>().eList;
    var currentMonth = context.watch<UIProvider>().selectedMonth + 1;

    List<ExpensesModel> eModel = [];
    Map<int, dynamic> mapExp;
    List<double> perDayList;

    //Ejempo con Map
    mapExp = eList.fold({}, (Map<int, dynamic> map, exp) {
      if (!map.containsKey(exp.day)) {
        map[exp.day] = 0.0;
      }
      map[exp.day] += exp.expenses;
      return map;
    });
    mapExp.forEach((key, value) {
      eModel.add(ExpensesModel(day: key, expenses: value));
    });
    // eList.sort((a, b) => a.day.compareTo(b.day));//ordenar por dia
    eModel.add(ExpensesModel(day: 0, expenses: 0.0));
    eModel.sort((a, b) => a.day.compareTo(b.day));
    List<charts.Series<ExpensesModel, num>> series = [
      charts.Series<ExpensesModel, num>(
        id: 'ExpensesPerDay',
        //datos de abajo horizontal
        domainFn: (v, i) => v.day,
        //datos que estan en la parte vertical
        measureFn: (v, i) => v.expenses,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.cyan),
        data: eModel,
      )
    ];

    //Ejemplo con double
    var currentDay = daysInMonth(currentMonth);

    perDayList = List.generate(currentDay + 1, (int i) {
      return eList
          .where((e) => e.day == (i))
          .map((e) => e.expenses)
          .fold(0.0, (a, b) => a + b);
    });
    List<charts.Series<double, int>> series2 = [
      charts.Series<double, int>(
          id: 'ExpensesPerDay',
          //datos de abajo horizontal
          //i = Dias
          domainFn: (v, i) => i!,
          //datos que estan en la parte vertical
          //v = Gastos
          measureFn: (v, i) => v,
          data: perDayList,
          seriesColor: charts.ColorUtil.fromDartColor(Colors.cyan),
          radiusPxFn: (v, i) {
            if (v == 0.0) {
              return 0;
            }
            return 4;
          })
    ];
    //
    return SizedBox(
      child: charts.LineChart(
        series2,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(
            includePoints: true, includeArea: true, areaOpacity: 0.2),
        //Los elementos del MeasureAxis son los que estan en vertical de lado izquierdo
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            lineStyle: charts.LineStyleSpec(
              //para darle color a las lineas que estan en horizontal
              color: charts.ColorUtil.fromDartColor(Colors.grey[800]!),
            ),
            //para poner el texto sobre la linea
            labelAnchor: charts.TickLabelAnchor.after,
            //para justificar hacia a izquierda los datos que estan en vertical
            labelJustification: charts.TickLabelJustification.outside,
          ),
          tickFormatterSpec:
              //para darle formato a los valores que estan en vertical
              charts.BasicNumericTickFormatterSpec.fromNumberFormat(
            NumberFormat.simpleCurrency(decimalDigits: 0),
          ),
          //pra agregar la cantidad de lineas que se ven en forma horizontal
          tickProviderSpec: const charts.BasicNumericTickProviderSpec(
            desiredTickCount: 8,
          ),
        ),
        domainAxis: charts.NumericAxisSpec(
          //para poner los datos que van en la parte de abajo de manera estatica
          tickProviderSpec: charts.StaticNumericTickProviderSpec([
            const charts.TickSpec(0, label: '0'),
            const charts.TickSpec(5, label: '5'),
            const charts.TickSpec(10, label: '10'),
            const charts.TickSpec(15, label: '15'),
            const charts.TickSpec(20, label: '20'),
            const charts.TickSpec(25, label: '25'),
            charts.TickSpec(currentDay, label: '$currentDay'),
          ]),
        ),
        selectionModels: [
          charts.SelectionModelConfig(
              changedListener: (charts.SelectionModel model) {
            if (model.hasDatumSelection) {
              pointAmount = getAmountFormat(
                model.selectedSeries[0]
                .measureFn(model.selectedDatum[0].index)!
                .toDouble()
              );
              pointDay = model.selectedSeries[0]
              .domainFn(model.selectedDatum[0].index)
              .toString();
            }
          }),
        ],
        //para los ocmportamientos de las graficas
        behaviors: [
          //para mostrar las lineas punteadas que señalan cada punto de manera horizontay y vertical
          charts.LinePointHighlighter(
            showHorizontalFollowLine:
                charts.LinePointHighlighterFollowLineType.nearest,
            showVerticalFollowLine:
                charts.LinePointHighlighterFollowLineType.nearest,
            //creamos una clase para crear un rectangulo que aparezca en cada punto
            symbolRenderer: SymbolRender(),
          ),
          //para ir mostrando los punto mientras pasamos el dedo por encima
          charts.SelectNearest(
            eventTrigger: charts.SelectionTrigger.tapAndDrag,
          ),
        ],
      ),
    );
  }
}

class SymbolRender extends charts.CircleSymbolRenderer {
  var txtStyle = style.TextStyle();
  @override
  void paint(
    charts.ChartCanvas canvas,
    Rectangle<num> bounds, {
    List<int>? dashPattern,
    charts.Color? fillColor,
    charts.FillPatternType? fillPattern,
    charts.Color? strokeColor,
    double? strokeWidthPx,
  }) {
    super.paint(
      canvas,
      bounds,
      dashPattern: dashPattern,
      fillColor: fillColor,
      fillPattern: fillPattern,
      strokeColor: strokeColor,
      strokeWidthPx: strokeWidthPx,
    );

    canvas.drawRect(
      Rectangle(
        bounds.left - 25,
        bounds.top - 35,
        bounds.width + 48,
        bounds.height + 18,
      ),
      //Color del fondo del rectangulo
      fill: charts.ColorUtil.fromDartColor(Colors.grey[850]!),
      //Color del contorno del rectangulo
      stroke: charts.ColorUtil.fromDartColor(Colors.white),
      //grosor del contorno
      strokeWidthPx: 1,
    );

    txtStyle.color = charts.MaterialPalette.white;
    txtStyle.fontSize = 10;
    
    canvas.drawText(
      element.TextElement(
        'Dia ${ChartLine.pointDay}\n${ChartLine.pointAmount}',
        style: txtStyle,
      ),
      (bounds.left - 20).round(),
      (bounds.top - 28).round(),
    );
  }
}
