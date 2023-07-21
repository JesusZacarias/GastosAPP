import 'package:exp_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntriesDetails extends StatefulWidget {
  const EntriesDetails({super.key});

  @override
  State<EntriesDetails> createState() => _EntriesDetailsState();
}

class _EntriesDetailsState extends State<EntriesDetails> {
  @override
  Widget build(BuildContext context) {
    final enList = context.watch<ExpensesProvider>().enList;
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Desglose de Ingresos'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                var fecha =enList[i].day.toString()+'/'+enList[i].month.toString()+'/'+enList[i].year.toString();
                return ListTile(
                  leading: Text(fecha, style: TextStyle(fontSize: 15.0),),
                  title: Text(enList[i].entries.toString()),
                );
              },
              childCount: enList.length,
            ),
          )
        ],
      ),
    );
  }
}
