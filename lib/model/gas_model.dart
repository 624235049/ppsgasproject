class GasModel {
  String gas_id;
  String gas_brand_id;
  String gas_size_id;
  String path_image;
  String price;
  String size;
  String quantity;

  GasModel(
      {this.gas_id,
      this.gas_brand_id,
      this.gas_size_id,
      this.path_image,
      this.price,
      this.size,
      this.quantity});

  GasModel.fromJson(Map<String, dynamic> json) {
    gas_id = json['gas_id'];
    gas_brand_id = json['gas_brand_id'];
    gas_size_id = json['gas_size_id'];
    path_image = json['path_image'];
    price = json['price'];
    size = json['size'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gas_id'] = this.gas_id;
    data['gas_brand_id'] = this.gas_brand_id;
    data['path_image'] = this.path_image;
    data['price'] = this.price;
    data['size'] = this.size;
    data['quantity'] = this.quantity;
    return data;
  }
}
