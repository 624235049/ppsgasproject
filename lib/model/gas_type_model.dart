class GasTypeModel {
  String id;
  String brandGas;
  String type;

  GasTypeModel({this.id, this.brandGas, this.type});

  GasTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandGas = json['brand_gas'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_gas'] = this.brandGas;
    data['type'] = this.type;
    return data;
  }
}
