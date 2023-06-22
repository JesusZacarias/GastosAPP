// To parse this JSON data, do
//
//     final combinedModel = combinedModelFromJson(jsonString);

import 'dart:convert';

CombinedModel combinedModelFromJson(String str) => CombinedModel.fromJson(json.decode(str));

String combinedModelToJson(CombinedModel data) => json.encode(data.toJson());

class CombinedModel {
    int? id;
    int? link;
    int year;
    int month;
    int day;
    String category;
    String color;
    String icon;
    String comment;
    double amount;

    CombinedModel({
        this.id,
        this.link,
        this.year = 0,
        this.month = 0,
        this.day = 0,
        this.category = 'Seleccione Categoria',
        this.color = '',
        this.icon = '',
        this.comment = '',
        this.amount = 0.0,
    });

    factory CombinedModel.fromJson(Map<String, dynamic> json) => CombinedModel(
        id: json["id"],
        link: json["link"],
        year: json["year"],
        month: json["month"],
        day: json["day"],
        category: json["category"],
        color: json["color"],
        icon: json["icon"],
        comment: json["comment"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "year": year,
        "month": month,
        "day": day,
        "category": category,
        "color": color,
        "icon": icon,
        "comment": comment,
        "amount": amount,
    };
}
