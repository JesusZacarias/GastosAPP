import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:exp_app/utils/icon_List.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:exp_app/utils/utils.dart';

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
    final exProvider = context.read<ExpensesProvider>();
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    Iterable<FeaturesModel> contain;

    contain = fList.where((element) =>
        element.category.toLowerCase() == widget.fModel.category.toLowerCase());

    _addCategory() {
      if (contain.isNotEmpty) {
        print('Ya existe la categoria');
      } else if (widget.fModel.category.isNotEmpty) {
        exProvider.addNewFeatures(
          widget.fModel
        );
        Navigator.pop(context);
        print('Procede a guardar');
      } else {
        print('No olvides nombrar una categoria');
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            //Ingresar Nombre de la Categoria
            Container(
              padding: EdgeInsets.only(bottom: viewInsets),
              child: ListTile(
                trailing: const Icon(
                  Icons.text_fields_outlined,
                  size: 35.0,
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
            //Seleccionar Color
            ListTile(
              onTap: () => _selectColor(),
              trailing: CircleColor(
                color: widget.fModel.color.toColor(),
                circleSize: 35.0,
              ),
              title: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).cardColor,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Center(
                  child: Text('Color'),
                ),
              ),
            ),
      
            //Seleccionar Icon
            ListTile(
              onTap: () => _selectedIcon(),
              trailing: Icon(
                widget.fModel.icon.toIcon(),
                size: 35.0,
              ),
              title: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).cardColor,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: const Center(
                  child: Text('Icono'),
                ),
              ),
            ),
            //Boton para guardar la categoria
            Row( 
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Constants.customButtom(
                        Colors.red, Colors.transparent, 'Cancelar'),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _addCategory(),
                    child: Constants.customButtom(
                        Colors.green, Colors.transparent, 'Aceptar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _selectColor() {
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isDismissible: false,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialColorPicker(
                selectedColor: widget.fModel.color.toColor(),
                physics: const NeverScrollableScrollPhysics(),
                circleSize: 50.0,
                onColorChange: (Color color) {
                  //Convierte los valores de los colores seleccionados a
                  //valores Hexadecimales
                  var hexColor =
                      '#${color.value.toRadixString(16).substring(2, 8)}';
                  setState(() {
                    widget.fModel.color = hexColor;
                  });
                },
                //
                //Deshabilita la selección las sombras
                // allowShades: false,
                //
                //Nos deja seleccionar el icono que queramos para seleccionar un color
                //iconSelected: Icons.cancel,
                //
                //Podemos agregar solo los colores que nececitemos con la
                // siguiente instrucción
                // colors: const [
                //   Colors.amber,
                //   Colors.blueGrey,
                // ],
                //
                //agrega todos los colores que tenemos disponibles
                //colors: fullMaterialColors,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Constants.customButtom(
                  Colors.green,
                  Colors.transparent,
                  'Listo',
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _selectedIcon() {
    final iconList = IconList().iconMap;
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemCount: iconList.length,
            itemBuilder: (context, i) {
              var key = iconList.keys.elementAt(i);
              return GestureDetector(
                child: Icon(
                  key.toIcon(),
                  size: 25.0,
                  color: Theme.of(context).dividerColor,
                ),
                onTap: () {
                  setState(() {
                    widget.fModel.icon = key;
                    Navigator.pop(context);
                  });
                },
              );
            },
          ),
        );
      },
    );
  }
}
