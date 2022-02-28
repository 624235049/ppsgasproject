class UserModel {
  String _id;
  String _chooseType;
  String _name;
  String _user;
  String _password;

  UserModel(
      {String id,
      String chooseType,
      String name,
      String user,
      String password}) {
    if (id != null) {
      this._id = id;
    }
    if (chooseType != null) {
      this._chooseType = chooseType;
    }
    if (name != null) {
      this._name = name;
    }
    if (user != null) {
      this._user = user;
    }
    if (password != null) {
      this._password = password;
    }
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get chooseType => _chooseType;
  set chooseType(String chooseType) => _chooseType = chooseType;
  String get name => _name;
  set name(String name) => _name = name;
  String get user => _user;
  set user(String user) => _user = user;
  String get password => _password;
  set password(String password) => _password = password;

  UserModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _chooseType = json['ChooseType'];
    _name = json['Name'];
    _user = json['User'];
    _password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['ChooseType'] = this._chooseType;
    data['Name'] = this._name;
    data['User'] = this._user;
    data['Password'] = this._password;
    return data;
  }
}
