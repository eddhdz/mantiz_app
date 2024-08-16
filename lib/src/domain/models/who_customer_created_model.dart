class WhoCustomerCreatedModel {
  int idProfile;
  String fullname;
  String email;
  String phone;
  String userToken;
  String typeUser;
  String typeRole;

  WhoCustomerCreatedModel(
      {required this.idProfile,
      required this.fullname,
      required this.email,
      required this.phone,
      required this.userToken,
      required this.typeUser,
      required this.typeRole});

  factory WhoCustomerCreatedModel.fromJson(Map<String, dynamic> json) {
    return WhoCustomerCreatedModel(
        idProfile: int.parse(json['idProfile'].toString()),
        fullname: json['fullname'],
        email: json['email'],
        phone: json['phone'],
        userToken: json['userToken'],
        typeUser: json['typeUser'],
        typeRole: json['typeRole']);
  }

  Map<String, dynamic> toJson() => {
        'idProfile': idProfile,
        'fullname': fullname,
        'email': email,
        'phone': phone,
        'userToken': userToken,
        'typeUser': typeUser,
        'typeRole': typeRole
      };
}
