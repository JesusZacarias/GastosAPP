import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/models/expenses_model.dart';
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/db_expenses.dart';
import 'package:exp_app/providers/db_features.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];
  List<ExpensesModel> eList = [];
  List<CombinedModel> cList = [];

  /*  Funciones de insertar */

  addNewExpense(CombinedModel cModel) async {
    var expenses = ExpensesModel(
        link: cModel.link,
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        expenses: cModel.amount);

    final id = await DBExpenses.db.addExpenses(expenses);
    expenses.id = id;
    eList.add(expenses);
    notifyListeners();
  }

  //Los siguientes segmentos de codigo tienen la misma funcionalidad
  //Lo que los hace diferentes es que el primero nos permite
  //Pasar los parametros de a 1x1, y nos puede generar algun error
  //a la hora de guardar los datos, es decir que es necesario
  //que los parametros se pasen de manera ordenada para no revolver los datos.
  // addNewFeatures(String category, String color, String icon) async {
  //   final newFeature = FeaturesModel(
  //     category: category,
  //     color: color,
  //     icon: icon
  //   );
  addNewFeatures(FeaturesModel newFeature) async {
    final id = await DBFeatures.db.addNewFeatures(newFeature);
    newFeature.id = id;
    fList.add(newFeature);
    notifyListeners();
  }

  /*  Funciones para leer */
  getExpensesByData(int month, int year) async {
    final response = await DBExpenses.db.getExpensesByDate(month, year);
    eList = [...response];
  }

  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();
    fList = [...response];
    notifyListeners();
  }

  /*  Funcones para actualizar*/
  updateExpense(CombinedModel cModel) async {
    var expenses = ExpensesModel(
        id: cModel.id,
        link: cModel.link,
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        expenses: cModel.amount);

    await DBExpenses.db.updateExpenses(expenses);
    notifyListeners();
  }

  updateFeatures(FeaturesModel features) async {
    await DBFeatures.db.updateFeature(features);
    getAllFeatures();
  }

  /*  Funcones para borrar*/
  deleteExpense(int id) async {
    await DBExpenses.db.deleteExpenses(id);
    notifyListeners();
  }

  /*  Getters to combined List  */

  List<CombinedModel> get allItemsList {
    List<CombinedModel> _cModel = [];

    for (var x in eList) {
      for (var y in fList) {
        if (x.link == y.id) {
          _cModel.add(
            CombinedModel(
                category: y.category,
                color: y.color,
                icon: y.icon,
                id: x.id,
                amount: x.expenses,
                comment: x.comment,
                year: x.year,
                month: x.month,
                day: x.day
                ),
          );
        }
      }
    }
    return cList = [..._cModel];
  }
}
