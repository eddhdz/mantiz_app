class BranchOfficeModel {
  int id;
  int fkSubcompany;
  String description;
  String location;
  String latitud;
  String longitud;
  String? imagen;
  String clave;
  String subcompany;
  String uuidBO;

  BranchOfficeModel(
      {required this.id,
      required this.fkSubcompany,
      required this.description,
      required this.location,
      required this.latitud,
      required this.longitud,
      required this.imagen,
      required this.clave,
      required this.subcompany,
      required this.uuidBO});

  factory BranchOfficeModel.fromJson(Map<String, dynamic> json) {
    return BranchOfficeModel(
        id: int.parse(json['id'].toString()),
        fkSubcompany: int.parse(json['fkSubcompany'].toString()),
        description: json['description'],
        location: json['location'],
        latitud: json['latitud'],
        longitud: json['longitud'],
        imagen: json['imagen'],
        clave: json['clave'],
        subcompany: json['subcompany'],
        uuidBO: json['uuidBO']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fkSubcompany': fkSubcompany,
        'description': description,
        'location': location,
        'latitud': latitud,
        'longitud': longitud,
        'imagen': imagen,
        'clave': clave,
        'subcompany': subcompany,
        'uuidBO': uuidBO
      };
}
