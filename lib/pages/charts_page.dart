import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/widgets/charts_page_wt/chart_line.dart';
import 'package:flutter/material.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(title: Text('Grafico'),centerTitle: true, elevation: 0.0,),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350.0,
            flexibleSpace: FlexibleSpaceBar(
                background: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Selector'),
                  Expanded(child: ChartLine()),
                ],
              ),
            )),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15.0),
              height: 40.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
