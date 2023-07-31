import 'dart:math';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/widgets/balance_page_wt/back_sheet.dart';
import 'package:exp_app/widgets/balance_page_wt/custom_fab.dart';
import 'package:exp_app/widgets/balance_page_wt/front_sheet.dart';
import 'package:exp_app/widgets/balance_page_wt/month_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final _scrollController = ScrollController();
  double _offset = 0;

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listener);
    _max;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
  }

  // Con el siguiente valor de terminamos a que altura se va a ocultar
  // el "Children" que esta encima del stack, entre mayor sea el valor
  // ocultara mas rapido el children de abajo y viceversa.
  final double _alturaOculta = 90;
  double get _max => max(90 - _offset * _alturaOculta, 0.0);

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final enList = context.watch<ExpensesProvider>().enList;

    return Scaffold(
      floatingActionButton: const CustomFAB(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
           SliverAppBar(
            elevation: 0.0,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MonthSelector(),
                  Text(
                    getBalance(eList, enList),
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.green,
                    ),
                  ),
                  const Text('Balance'),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                children: [
                  const BackSheet(),
                  Padding(
                    padding: EdgeInsets.only(top: _max),
                    child: const FrontSheet(),
                  ),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}
