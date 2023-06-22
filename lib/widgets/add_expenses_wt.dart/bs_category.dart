import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:exp_app/widgets/add_expenses_wt.dart/category_list.dart';
import 'package:flutter/material.dart';

class BSCategory extends StatefulWidget {
  final CombinedModel cModel;
  const BSCategory({super.key, required this.cModel});

  @override
  State<BSCategory> createState() => _BSCategoryState();
}

class _BSCategoryState extends State<BSCategory> {
  @override
  Widget build(BuildContext context) {
    bool hasData = false;

    if (widget.cModel.category != 'Seleccione Categoria') {
      hasData = true;
    }

    return GestureDetector(
      onTap: () {
        _categorySelected();
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Icon(
              (hasData) ? widget.cModel.icon.toIcon() : Icons.category_outlined,
              size: 35.0,
              color: widget.cModel.color.toColor(),
            ),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.8,
                    color: (hasData)
                        ? widget.cModel.color.toColor()
                        : Theme.of(context).dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Center(
                  child: Text(
                    widget.cModel.category,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _categorySelected() {
    var catList = CategoryList().catLis;

    void _itemSelected(String category, String color, String icon) {
      setState(() {
        widget.cModel.category = category;
        widget.cModel.color = color;
        widget.cModel.icon = icon;
        Navigator.pop(context);
      });
    }

    var _widgets = [
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: catList.length,
        itemBuilder: (_, i) {
          var item = catList[i];

          return ListTile(
            leading: Icon(
              item.icon.toIcon(),
              color: item.color.toColor(),
              size: 35.0,
            ),
            title: Text(
              item.category,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 20.0,
            ),
            onTap: () {
              _itemSelected(
                item.category,
                item.color,
                item.icon,
              );
            },
          );
        },
      ),
      const Divider(
        thickness: 2.0,
      ),
      ListTile(
        leading: const Icon(
          Icons.create_new_folder_outlined,
          size: 35.0,
        ),
        title: const Text(
          'Crear Nueva Categoria',
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 20.0,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.edit_outlined,
          size: 35.0,
        ),
        title: const Text(
          'Editar Categoria',
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 20.0,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ];

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.8,
          child: ListView(
            children: _widgets,
          ),
        );
      },
    );
  }
}
