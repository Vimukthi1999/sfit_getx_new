// To parse this JSON data, do
//
//     final typeofHoursDpModel = typeofHoursDpModelFromJson(jsonString);

import 'dart:convert';

ProductTypeDpModel typeofHoursDpModelFromJson(String str) => ProductTypeDpModel.fromJson(json.decode(str));

String typeofHoursDpModelToJson(ProductTypeDpModel data) => json.encode(data.toJson());

class ProductTypeDpModel {
    final List<DatumProductType> data;
    final String message;
    final bool success;
    final String messages;

    ProductTypeDpModel({
        required this.data,
        required this.message,
        required this.success,
        required this.messages,
    });

    factory ProductTypeDpModel.fromJson(Map<String, dynamic> json) => ProductTypeDpModel(
        data: List<DatumProductType>.from(json["data"].map((x) => DatumProductType.fromJson(x))),
        message: json["message"],
        success: json["success"],
        messages: json["messages"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "success": success,
        "messages": messages,
    };
}

class DatumProductType {
    final String dropId;
    final String dropValue;

    DatumProductType({
        required this.dropId,
        required this.dropValue,
    });

    factory DatumProductType.fromJson(Map<String, dynamic> json) => DatumProductType(
        dropId: json["drop_id"],
        dropValue: json["drop_value"],
    );

    Map<String, dynamic> toJson() => {
        "drop_id": dropId,
        "drop_value": dropValue,
    };
}
