import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCategory extends StatefulWidget {
  final FeaturesModel fModel;
  const CreateCategory({super.key, required this.fModel});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  @override
  Widget build(BuildContext context) {
    final fList = context.watch<ExpensesProvider>().fList;
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    Iterable<FeaturesModel> contain;

    contain = fList.where((element) =>
        element.category.toLowerCase() == widget.fModel.category.toLowerCase());


    _addCategory() {
      if(contain.isNotEmpty) {
        print('Ya existe la categoria');
      }else if(widget.fModel.category.isNotEmpty){
        print('Procede a guardar');
      }else {
        print('No olvides nombrar una categoria');
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: viewInsets),
            child: ListTile(
              trailing: const Icon(
                Icons.text_fields_outlined,
              ),
              title: TextFormField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                initialValue: widget.fModel.category,
                decoration: InputDecoration(
                  hintText: 'nombre una categoria',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                onChanged: (txt) {
                  widget.fModel.category = txt;
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _addCategory();
            },
            child: const Text('Done'),
          )
        ],
      ),
    );
  }
}
