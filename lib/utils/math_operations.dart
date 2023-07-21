import 'package:exp_app/models/entries_model.dart';
import 'package:exp_app/models/expenses_model.dart';
import 'package:intl/intl.dart';
export 'package:exp_app/utils/math_operations.dart';
getAmountFormat(double amount) {
  return NumberFormat.simpleCurrency().format(amount);
}

getSumOfExp(List<ExpensesModel> eList) {
  double _eList;
  _eList = eList.map((e) => e.expenses).fold(0.0, (a,b) => a + b);
  return _eList;
}

getSumOfEntrie(List<EntriesModel> enList) {
  double _enList;
  _enList = enList.map((e) => e.entries).fold(0.0, (a,b) => a + b);
  return _enList;
}

getBalance(List<ExpensesModel> eList, List<EntriesModel> enList) {
  double _balance;
  _balance = getSumOfEntrie(enList) - getSumOfExp(eList);
  return getAmountFormat(_balance);
}