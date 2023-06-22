import 'package:exp_app/pages/balance_page.dart';
import 'package:exp_app/pages/charts_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';
import '../widgets/home_page_wt/custom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomePage(),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UIProvider>(context);

    final currentIndex = uiProvider.bnbIndex;


    switch (currentIndex) {
      case 0:
        return const BalancePage();
      case 1:
        return const ChartsPage();
      default: 
        return const BalancePage();
    }
  }
}