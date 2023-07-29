import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/widgets/charts_page_wt/chart_line.dart';
import 'package:exp_app/widgets/charts_page_wt/chart_pie.dart';
import 'package:exp_app/widgets/charts_page_wt/chart_scatterplot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartSwitch extends StatelessWidget {
  const ChartSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final current = context.watch<UIProvider>().selectedChart;

    switch(current) {
      case 'Gráfico Lineal' : return const ChartLine();
      case 'Gráfico Pie' : return const ChartPie();
      case 'Gráfico de Dispersión' : return const ChartScatterplot();
      default : return const ChartPie();
    }
  }
}