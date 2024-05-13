class SendSerialInfoToSaveAPI {
  late final String item;
  late final String itemdes;
  late final String usr_desc;
  late final String org_purpose;
  late final String purpose;
  late final String serial;
  late final String qty;
  late final String cost;
  late final String uom;

  SendSerialInfoToSaveAPI({
    required this.item,
    required this.itemdes,
    required this.usr_desc,
    required this.org_purpose,
    required this.purpose,
    required this.serial,
    required this.qty,
    required this.cost,
    required this.uom,
  });

  factory SendSerialInfoToSaveAPI.fromJson(Map<String, dynamic> serialinfo) {
    return SendSerialInfoToSaveAPI(
      item: serialinfo['item'],
      itemdes: serialinfo['item_des'],
      usr_desc: serialinfo['item_des'],
      org_purpose: serialinfo['purpose'],
      purpose: serialinfo['purpose'],
      serial: serialinfo['serial_no'],
      qty: serialinfo['quantity'],
      cost: serialinfo['sp'],
      uom: serialinfo['uom'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> serialinfo = Map<String, dynamic>();
    serialinfo['item'] = item;
    serialinfo['itemdes'] = itemdes;
    serialinfo['usr_desc'] = usr_desc;
    serialinfo['org_purpose'] = org_purpose;
    serialinfo['purpose'] = purpose;
    serialinfo['serial'] = serial;
    serialinfo['qty'] = qty;
    serialinfo['cost'] = cost;
    serialinfo['uom'] = uom;

    return serialinfo;
  }
}
