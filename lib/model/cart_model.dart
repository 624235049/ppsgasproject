class CartModel {
  int id;
  String gas_id;
  String gas_brand_id;
  String gas_brand_name;
  String gas_size_id;
  String price;
  String amount;
  String sum;
  String distance;
  String transport;

  CartModel(
      {this.id,
      this.gas_id,
      this.gas_brand_id,
      this.gas_brand_name,
      this.gas_size_id,
      this.price,
      this.amount,
      this.sum,
      this.distance,
      this.transport});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gas_id = json['gas_id'];
    gas_brand_id = json['gas_brand_id'];
    gas_brand_name = json['gas_brand_name'];
    gas_size_id = json['gas_size_id'];
    price = json['price'];
    amount = json['amount'];
    sum = json['sum'];
    distance = json['distance'];
    transport = json['transport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gas_id'] = this.gas_id;
    data['gas_brand_id'] = this.gas_brand_id;
    data['gas_brand_name'] = this.gas_brand_name;
    data['gas_size_id'] = this.gas_size_id;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['sum'] = this.sum;
    data['distance'] = this.distance;
    data['transport'] = this.transport;
    return data;
  }
}
