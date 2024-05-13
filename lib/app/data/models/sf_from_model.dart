import 'dart:convert';

SfFromModel sfFromModelFromJson(String str) => SfFromModel.fromJson(json.decode(str));

String sfFromModelToJson(SfFromModel data) => json.encode(data.toJson());

class SfFromModel {
  final List<DatumSFfrom> data;

  SfFromModel({
    required this.data,
  });

  factory SfFromModel.fromJson(Map<String, dynamic> json) => SfFromModel(
        data: List<DatumSFfrom>.from(json["data"].map((x) => DatumSFfrom.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumSFfrom {
  final String companyName;
  final String contractId;
  final String requisitionNo;
  final String startDate;
  final String requestedDate;
  final String engineer;
  var signEngineer;
  var signCustomer;
  final Option option;

  DatumSFfrom({
    required this.companyName,
    required this.contractId,
    required this.requisitionNo,
    required this.startDate,
    required this.requestedDate,
    required this.engineer,
    required this.signEngineer,
    required this.signCustomer,
    required this.option,
  });

  factory DatumSFfrom.fromJson(Map<String, dynamic> json) => DatumSFfrom(
        companyName: json["company_name"],
        contractId: json["contract_id"],
        requisitionNo: json["requisition_no"],
        startDate: json["start_date"],
        requestedDate: json["requested_date"],
        engineer: json["engineer"],
        signEngineer: json["sign_engineer"],
        signCustomer: json["sign_customer"],
        option: Option.fromJson(json["option"]),
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "contract_id": contractId,
        "requisition_no": requisitionNo,
        "start_date": startDate,
        "requested_date": requestedDate,
        "engineer": engineer,
        "sign_engineer": signEngineer,
        "sign_customer": signCustomer,
        "option": option.toJson(),
      };
}

class Option {
  final bool edit;
  final bool delete;
  final bool view;
  bool emailSent;
  bool email;
  final bool signature;
  final bool print;

  Option({
    required this.edit,
    required this.delete,
    required this.view,
    required this.emailSent,
    required this.email,
    required this.signature,
    required this.print,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        edit: json["edit"],
        delete: json["delete"],
        view: json["view"],
        emailSent: json["email_sent"],
        email: json["email"],
        signature: json["signature"],
        print: json["print"],
      );

  Map<String, dynamic> toJson() => {
        "edit": edit,
        "delete": delete,
        "view": view,
        "email_sent": emailSent,
        "email": email,
        "signature": signature,
        "print": print,
      };
}
