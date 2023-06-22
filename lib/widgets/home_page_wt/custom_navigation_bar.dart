
import 'package:exp_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {

        // (1)
        // De esta manera los parametros (context, listener = true)
        // listener siempre estra en true.
        // Con el codigo por separado limitamos a que cuando se usa
        // el watch este en true y cuando solo esta ne read este en false.
        // Solo lo implentamos por separado para tener mas claro
        // lo que se esta haciendo con el provider.
        //context.watch  ==  Permite observar los valores de Privider (Get)
        //context.read  ==   Permite interactuar con los valores 
        //                   del provider (Set) sin la necesidad de observar.

    // final uiProvider = Provider.of<UIProvider>(context);

    final watchIndex = context.watch<UIProvider>();
    final read =  context.read<UIProvider>();

    return BottomNavigationBar(
      //(1)
      // currentIndex: uiProvider.bnbIndex,
      // onTap: (int i) => uiProvider.bnbIndex = i,
       currentIndex: watchIndex.bnbIndex,
       onTap: (int i) => read.bnbIndex = i,
      elevation: 0.0,
      items: const [
        BottomNavigationBarItem(
          label: 'Balance',
          icon: Icon(Icons.account_balance_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Gráficos',
          icon: Icon(Icons.bar_chart_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Ajustes',
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}
