class DetailShopModel {
  String _id;
  String _nameShop;
  String _address;
  String _phone;
  String _urlImage;
  String _lat;
  String _lng;
  String _token;

  DetailShopModel({
    String id,
    String nameShop,
    String address,
    String phone,
    String urlImage,
    String lat,
    String lng,
    String token,
  });

  String get id => _id;
  set id(String id) => _id = id;
  String get nameShop => _nameShop;
  set nameShop(String nameShop) => _nameShop = nameShop;
  String get address => _address;
  set address(String address) => _address = address;
  String get phone => _phone;
  set phone(String phone) => _phone = phone;
  String get urlImage => _urlImage;
  set urlImage(String urlImage) => _urlImage = urlImage;
  String get lat => _lat;
  set lat(String lat) => _lat = lat;
  String get lng => _lng;
  set lng(String lng) => _lng = lng;
  String get token => _token;
  set token(String token) => _token = token;

  DetailShopModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nameShop = json['NameShop'];
    _address = json['Address'];
    _phone = json['Phone'];
    _urlImage = json['UrlPicture'];
    _lat = json['Lat'];
    _lng = json['Lng'];
    _token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['NameShop'] = this._nameShop;
    data['Address'] = this._address;
    data['Phone'] = this._phone;
    data['UrlPicture'] = this._urlImage;
    data['Lat'] = this._lat;
    data['Lng'] = this._lng;
    data['Token'] = this._token;
    return data;
  }
}
