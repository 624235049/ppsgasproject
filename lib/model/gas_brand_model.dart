class GasBrandModel {
  String gas_brand_id;
  String gas_brand_name;
  String gas_brand_image;

  GasBrandModel({this.gas_brand_id, this.gas_brand_name, this.gas_brand_image});

  GasBrandModel.fromJson(Map<String, dynamic> json) {
    gas_brand_id = json['gas_brand_id'];
    gas_brand_name = json['gas_brand_name'];
    gas_brand_image = json['gas_brand_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gas_brand_id'] = this.gas_brand_id;
    data['gas_brand_name'] = this.gas_brand_id;
    data['gas_brand_image'] = this.gas_brand_image;
    return data;
  }
}
