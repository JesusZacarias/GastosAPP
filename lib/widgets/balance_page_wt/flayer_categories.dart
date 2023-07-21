import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

class FlayersCategories extends StatelessWidget {
  const FlayersCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.watch<ExpensesProvider>();
    //    gList = GroupList
    final gList = exProvider.groupItemsList;
    List<CombinedModel> limitList = [];
    bool hashLimit = false;

    if (gList.length >= 6) {
      limitList = gList.sublist(0, 5);
      hashLimit = true;
    }

    if (limitList.length == 5) {
      limitList.add(
        CombinedModel(category: 'Otros...', icon: 'otros', color: '#20634b'),
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (hashLimit) ? limitList.length : gList.length,
            itemBuilder: (_, i) {
              var item = gList[i];
              if (hashLimit == true) item = limitList[i];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'cat_details',
                    arguments: item,
                  );
                },
                child: ListTile(
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -2),
                  horizontalTitleGap: -5,
                  leading: Icon(
                    item.icon.toIcon(),
                    color: item.color.toColor(),
                  ),
                  title: Text(
                    item.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // trailing: Text(
                  //   getAmountFormat(item.amount),
                  // ),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: CircleColor(
            color: Colors.green,
            circleSize: 150.0,
          ),
        )
      ],
    );
  }
}
