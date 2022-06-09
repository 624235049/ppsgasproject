class GasSizeModel {
  String gasSizeId;
  String gasSizeName;
  String pathImage;

  GasSizeModel({this.gasSizeId, this.gasSizeName, this.pathImage});

  GasSizeModel.fromJson(Map<String, dynamic> json) {
    gasSizeId = json['gas_size_id'];
    gasSizeName = json['gas_size_name'];
    pathImage = json['pathImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gas_size_id'] = this.gasSizeId;
    data['gas_size_name'] = this.gasSizeName;
    data['pathImage'] = this.pathImage;
    return data;
  }
}
