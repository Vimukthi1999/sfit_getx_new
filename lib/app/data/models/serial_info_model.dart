// To parse this JSON data, do
//
//     final serialInfoModel = serialInfoModelFromJson(jsonString);

import 'dart:convert';

SerialInfoModel serialInfoModelFromJson(String str) => SerialInfoModel.fromJson(json.decode(str));

String serialInfoModelToJson(SerialInfoModel data) => json.encode(data.toJson());

class SerialInfoModel {
    final SerialData data;
    final String message;
    final bool success;
    final String messages;

    SerialInfoModel({
        required this.data,
        required this.message,
        required this.success,
        required this.messages,
    });

    

    factory SerialInfoModel.fromJson(Map<String, dynamic> json) => SerialInfoModel(
        data: SerialData.fromJson(json["data"]),
        message: json["message"],
        success: json["success"],
        messages: json["messages"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "success": success,
        "messages": messages,
    };
}

class SerialData {
  var item;
  var quantity;
  var purpose;
  var uprice;
  var serialNo;
  var sp;
  var itemDes;
  var stdCostPerUnit;
  var uom;

    SerialData({
        required this.item,
        required this.quantity,
        required this.purpose,
        required this.uprice,
        required this.serialNo,
        required this.sp,
        required this.itemDes,
        required this.stdCostPerUnit,
        required this.uom,
    });

    factory SerialData.fromJson(Map<String, dynamic> json) => SerialData(
        item: json["item"],
        quantity: json["quantity"],
        purpose: json["purpose"],
        uprice: json["uprice"],
        serialNo: json["serial_no"],
        sp: json["sp"],
        itemDes: json["item_des"],
        stdCostPerUnit: json["std_cost_per_unit"],
        uom: json["uom"],
    );

    Map<String, dynamic> toJson() => {
        "item": item,
        "quantity": quantity,
        "purpose": purpose,
        "uprice": uprice,
        "serial_no": serialNo,
        "sp": sp,
        "item_des": itemDes,
        "std_cost_per_unit": stdCostPerUnit,
        "uom": uom,
    };
}
