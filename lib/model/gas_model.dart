class GasModel {
  String id;
  String idShop;
  String brandGas;
  String pathImage;
  String price;
  String size;
  String quantity;
  String gastype;

  GasModel(
      {this.id,
      this.idShop,
      this.brandGas,
      this.pathImage,
      this.price,
      this.size,
      this.quantity,
      this.gastype});

  GasModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idShop = json['idShop'];
    brandGas = json['BrandGas'];
    pathImage = json['PathImage'];
    price = json['Price'];
    size = json['Size'];
    quantity = json['Quantity'];
    gastype = json['Gastype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idShop'] = this.idShop;
    data['BrandGas'] = this.brandGas;
    data['PathImage'] = this.pathImage;
    data['Price'] = this.price;
    data['Size'] = this.size;
    data['Quantity'] = this.quantity;
    data['Gastype'] = this.gastype;
    return data;
  }
}
