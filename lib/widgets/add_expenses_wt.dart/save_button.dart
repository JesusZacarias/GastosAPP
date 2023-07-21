import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  final bool hasdata;
  const SaveButton({super.key, required this.cModel, required this.hasdata});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
      onTap: () {
        if (cModel.amount != 0.00 && cModel.link != null) {
          (hasdata)
              ? exProvider.updateExpense(cModel)
              : exProvider.addNewExpense(cModel);
          Fluttertoast.showToast(
            msg: (hasdata)
                ? 'Gasto Editado Correctamente'
                : 'Gasto Agregado Correctamente',
            backgroundColor: Colors.green,
          );
          uiProvider.bnbIndex = 0;
          Navigator.pop(context);
        } else if (cModel.amount == 0.00) {
          Fluttertoast.showToast(
            msg: 'Agrega un Gasto',
            backgroundColor: Colors.red,
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Selecciona una Categoria',
            backgroundColor: Colors.red,
          );
        }
      },
      child: SizedBox(
        height: 70.0,
        width: 140.0,
        child: Constants.customButtom(
          Colors.green,
          Colors.white,
          (hasdata) ? 'Editar' : 'Guardar',
        ),
      ),
    );
  }
}
