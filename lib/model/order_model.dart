class OrderModel {
  String orderId;
  String orderDateTime;
  String user_id;
  String user_name;
  String gas_id;
  String gas_brand_id;
  String gas_size_id;
  String distance;
  String transport;
  String gas_brand_name;
  String price;
  String amount;
  String sum;
  String riderId;
  String status;

  OrderModel(
      {this.orderId,
      this.orderDateTime,
      this.user_id,
      this.user_name,
      this.gas_id,
      this.gas_brand_id,
      this.gas_size_id,
      this.distance,
      this.transport,
      this.gas_brand_name,
      this.price,
      this.amount,
      this.sum,
      this.riderId,
      this.status});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderDateTime = json['order_date_time'];
    user_id = json['user_id'];
    user_name = json['user_name'];
    gas_id = json['gas_id'];
    gas_brand_id = json['gas_brand_id'];
    gas_size_id = json['gas_size_id'];
    distance = json['distance'];
    transport = json['transport'];
    gas_brand_name = json['gas_brand_name'];
    price = json['price'];
    amount = json['amount'];
    sum = json['sum'];
    riderId = json['rider_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_date_time'] = this.orderDateTime;
    data['user_id'] = this.user_id;
    data['user_name'] = this.user_name;
    data['gas_id'] = this.gas_id;
    data['gas_brand_id'] = this.gas_brand_id;
    data['gas_size_id'] = this.gas_size_id;
    data['distance'] = this.distance;
    data['transport'] = this.transport;
    data['gas_brand_name'] = this.gas_brand_name;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['sum'] = this.sum;
    data['rider_id'] = this.riderId;
    data['status'] = this.status;
    return data;
  }
}
