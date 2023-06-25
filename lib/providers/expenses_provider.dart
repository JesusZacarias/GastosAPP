
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/db_features.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> fList = [];

  addNewFeatures(String category, String color, String icon) async {
    final newFeature = FeaturesModel(
      category: category,
      color: color,
      icon: icon
    );

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
}