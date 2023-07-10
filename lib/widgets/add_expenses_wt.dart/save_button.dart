import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  const SaveButton({super.key, required this.cModel});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();

    return GestureDetector(
      onTap: () {
        if (cModel.amount != 0.00 && cModel.link != null) {
          exProvider.addNewExpense(cModel);
          Fluttertoast.showToast(
            msg: 'Se Gasto Correctamente',
            backgroundColor: Colors.green,
          );
          Navigator.pop(context);
        } else if (cModel.amount == 0.00) {
          Fluttertoast.showToast(
            msg: 'Agrega un Gasto',
            backgroundColor: Colors.red,
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Selecciona una categoria',
            backgroundColor: Colors.red,
          );
        }
      },
      child: SizedBox(
        height: 70.0,
        width: 140.0,
        child: Constants.customButtom(Colors.green, Colors.white, 'Guardar'),
      ),
    );
  }
}
