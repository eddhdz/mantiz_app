class DeviceModel {
  int id;
  String code;
  String uuidDevice;
  String description;
  String barCode;
  String specs;
  String subCategory;
  String category;
  String product;
  String typeService;
  String brand;

  DeviceModel(
      {required this.id,
      required this.code,
      required this.uuidDevice,
      required this.description,
      required this.barCode,
      required this.specs,
      required this.subCategory,
      required this.category,
      required this.product,
      required this.typeService,
      required this.brand});

  factory DeviceModel.fromJson(Map<String, dynamic> json) {
    return DeviceModel(
        id: int.parse(json['id'].toString()),
        code: json['code'],
        uuidDevice: json['uuidDevice'],
        description: json['description'],
        barCode: json['barCode'],
        specs: json['specs'],
        subCategory: json['subCategory'],
        category: json['category'],
        product: json['product'],
        typeService: json['typeService'],
        brand: json['brand']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'uuidDevice': uuidDevice,
        'description': description,
        'barCode': barCode,
        'specs': specs,
        'subCategory': subCategory,
        'category': category,
        'product': product,
        'typeService': typeService,
        'brand': brand
      };
}
