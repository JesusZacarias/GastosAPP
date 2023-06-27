import 'dart:math';

import 'package:exp_app/widgets/balance_page_wt/back_sheet.dart';
import 'package:exp_app/widgets/balance_page_wt/custom_fab.dart';
import 'package:exp_app/widgets/balance_page_wt/front_sheet.dart';
import 'package:flutter/material.dart';

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
      print(_max);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_listener);
    _max;
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
    return Scaffold(
      floatingActionButton: const CustomFAB(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          const SliverAppBar(
            elevation: 0.0,
            expandedHeight: 120.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$2500.00',
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.green,
                    ),
                  ),
                  Text('Balance'),
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
