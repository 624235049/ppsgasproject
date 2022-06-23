class DetailShopModel {
  String id;
  String nameShop;
  String address;
  String phone;
  String urlPicture;
  String lat;
  String lng;
  String token;

  DetailShopModel(
      {this.id,
      this.nameShop,
      this.address,
      this.phone,
      this.urlPicture,
      this.lat,
      this.lng,
      this.token});

  DetailShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameShop = json['NameShop'];
    address = json['Address'];
    phone = json['Phone'];
    urlPicture = json['UrlPicture'];
    lat = json['Lat'];
    lng = json['Lng'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['NameShop'] = this.nameShop;
    data['Address'] = this.address;
    data['Phone'] = this.phone;
    data['UrlPicture'] = this.urlPicture;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    data['Token'] = this.token;
    return data;
  }
}
