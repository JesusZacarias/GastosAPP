import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/widgets/add_entries_wt.dart/save_en_button.dart'; 
import 'package:exp_app/widgets/add_expenses_wt.dart/bs_num_keyboard.dart';
import 'package:exp_app/widgets/add_expenses_wt.dart/comment_box.dart';
import 'package:exp_app/widgets/add_expenses_wt.dart/date_picker.dart'; 
import 'package:flutter/material.dart';

class AddEntries extends StatelessWidget {
  const AddEntries({super.key});

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Ingresos'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          BsNumKeyboard(
            cModel: cModel,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: Constants.sheetBoxDecoration(
                Theme.of(context).primaryColorDark,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DatePicker(cModel: cModel), 
                  CommentBox(cModel: cModel),
                  Expanded(
                    child: Center(
                      child: SaveEnButton(cModel: cModel,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
