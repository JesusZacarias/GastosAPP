
import 'dart:convert';

ExpensesModel expensesModelFromJson(String str) => ExpensesModel.fromJson(json.decode(str));

String expensesModelToJson(ExpensesModel data) => json.encode(data.toJson());

class ExpensesModel {
    int? id;
    int? link;
    int year;
    int month;
    int day;
    String comment;
    double expenses;

    ExpensesModel({
        this.link,
        this.id,
        this.year = 0,
        this.month = 0,
        this.day = 0,
        this.comment = "",
        this.expenses = 0.0,
    });

    factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
        id: json["id"],
        link: json["link"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        comment: json["comment"],
        expenses: json["expenses"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "year": year,
        "month": month,
        "day": day,
        "comment": comment,
        "expenses": expenses,
    };
}
