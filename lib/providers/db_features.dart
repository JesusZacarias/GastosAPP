import 'package:exp_app/models/features_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBFeatures {
  static Database? _database;
  static final DBFeatures db = DBFeatures._();
  DBFeatures._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    var dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'FeatureDB.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          '''CREATE TABLE  Features (
          id INTEGER PRIMARY KEY, 
          category TEXT, color TEXT, 
          icon TEXT)''',
        );
      },
    );
  }

  addNewFeatures(FeaturesModel feature) async {
    final db = await database;
    final response = db.insert('Features', feature.toJson());
    return response;
  }

  Future<List<FeaturesModel>> getAllFeatures() async {
    final db = await database;
    final response = await db.query('Features'); //retorna como Json

    //Condicion ternaria
    //Si fList no esta vacia regresa la lista de FeaturesModel
    //Caso contrario retorna una lista vacia.
    List<FeaturesModel> fList = response.isNotEmpty
    ? response.map((e) => FeaturesModel.fromJson(e)).toList()
    : [];
    return fList;
  }

  Future<int> updateFeature(FeaturesModel feature) async {
    final db = await database;
    final response = db.update('Features', feature.toJson(), 
    where: 'id = ?', whereArgs: [feature.id],);
    return response;
  }
}
