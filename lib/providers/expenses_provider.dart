
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/db_features.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];
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

  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();
    fList = [...response];
    notifyListeners();
  }

  updateFeatures(FeaturesModel features) async {
    await DBFeatures.db.updateFeature(features);
    getAllFeatures();
  }
}