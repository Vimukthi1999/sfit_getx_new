class T4 {
  var item;
  var quantity;
  var purpose;
  var serialNo;
  var sp;
  var itemDes;
  var uom;
  var userdesc;

  T4({
    required this.item,
    required this.quantity,
    required this.purpose,
    required this.serialNo,
    required this.sp,
    required this.itemDes,
    required this.userdesc,
    required this.uom,
  });

  factory T4.fromJson(Map<String, dynamic> json) => T4(
        item: json["item"],
        quantity: json["quantity"],
        purpose: json["purpose"],
        serialNo: json["serial_no"],
        sp: json["sp"],
        itemDes: json["item_des"],
        userdesc: json["usr_desc"],
        uom: json["uom"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "quantity": quantity,
        "purpose": purpose,
        "serial_no": serialNo,
        "sp": sp,
        "item_des": itemDes,
        "std_cost_per_unit": userdesc,
        "uom": uom,
      };
}
