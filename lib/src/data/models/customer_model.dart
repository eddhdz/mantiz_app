class CustomerModel {
  int id;
  int fkPartner;
  String partner;
  int fkCustomer;
  String customer;

  CustomerModel(
      {required this.id,
      required this.fkPartner,
      required this.partner,
      required this.fkCustomer,
      required this.customer});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
        id: int.parse(json['id'].toString()),
        fkPartner: int.parse(json['fkPartner'].toString()),
        partner: json['partner'],
        fkCustomer: int.parse(json['fkCustomer'].toString()),
        customer: json['customer']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fkPartner': fkPartner,
        'partner': partner,
        'fkCustomer': fkCustomer,
        'customer': customer
      };
}
