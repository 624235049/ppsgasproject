class GasSizeModel {
  String gas_size_id;
  String gas_size_name;
  String pathImage;

  GasSizeModel({this.gas_size_id, this.gas_size_name, this.pathImage});

  GasSizeModel.fromJson(Map<String, dynamic> json) {
    gas_size_id = json['gas_size_id'];
    gas_size_name = json['gas_size_name'];
    pathImage = json['pathImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gas_size_id'] = this.gas_size_id;
    data['gas_size_name'] = this.gas_size_name;
    data['pathImage'] = this.pathImage;
    return data;
  }
}
