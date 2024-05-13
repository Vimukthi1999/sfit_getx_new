// To parse this JSON data, do
//
//     final assetCodeDetailsModel = assetCodeDetailsModelFromJson(jsonString);

import 'dart:convert';

MachineTypeModel assetCodeDetailsModelFromJson(String str) => MachineTypeModel.fromJson(json.decode(str));

String assetCodeDetailsModelToJson(MachineTypeModel data) => json.encode(data.toJson());

class MachineTypeModel {
    final List<MachineTypeList> machineTypeList;

    MachineTypeModel({
        required this.machineTypeList,
    });

    factory MachineTypeModel.fromJson(Map<String, dynamic> json) => MachineTypeModel(
        machineTypeList: List<MachineTypeList>.from(json["machine_type_list"].map((x) => MachineTypeList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "machine_type_list": List<dynamic>.from(machineTypeList.map((x) => x.toJson())),
    };
}

class MachineTypeList {
    final String typeId;
    final String typeName;

    MachineTypeList({
        required this.typeId,
        required this.typeName,
    });

    factory MachineTypeList.fromJson(Map<String, dynamic> json) => MachineTypeList(
        typeId: json["type_id"],
        typeName: json["type_name"],
    );

    Map<String, dynamic> toJson() => {
        "type_id": typeId,
        "type_name": typeName,
    };
}
