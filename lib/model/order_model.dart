class OrderModel {
  String id;
  String orderDateTime;
  String id_Gas;
  String cus_id;
  String nameUser;
  String emp_id;
  String address_id;
  String pay_id;
  String price;
  String qty;
  String sum;
  String status;

  OrderModel(
      {this.id,
      this.orderDateTime,
      this.id_Gas,
      this.cus_id,
      this.nameUser,
      this.emp_id,
      this.address_id,
      this.price,
      this.qty,
      this.sum,
      this.status});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderDateTime = json['OrderDateTime'];
    id_Gas = json['id_Gas'];
    cus_id = json['cus_id'];
    nameUser = json['NameUser'];
    emp_id = json['emp_id'];
    address_id = json['address_id'];
    pay_id = json['pay_id'];
    price = json['Price'];
    qty = json['qty'];
    sum = json['Sum'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['OrderDateTime'] = this.orderDateTime;
    data['cus_id'] = this.cus_id;
    data['id_Gas'] = this.id_Gas;
    data['NameUser'] = this.nameUser;
    data['emp_id'] = this.emp_id;
    data['address_id'] = this.address_id;
    data['pay_id'] = this.pay_id;
    data['Price'] = this.price;
    data['qty'] = this.qty;
    data['Sum'] = this.sum;
    data['Status'] = this.status;
    return data;
  }
}
