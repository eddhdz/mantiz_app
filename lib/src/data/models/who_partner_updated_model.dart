class WhoPartnerUpdatedModel {
  int idProfile;
  String fullname;
  String email;
  String phone;
  String userToken;
  String typeUser;
  String typeRole;

  WhoPartnerUpdatedModel(
      {required this.idProfile,
      required this.fullname,
      required this.email,
      required this.phone,
      required this.userToken,
      required this.typeUser,
      required this.typeRole});

  factory WhoPartnerUpdatedModel.fromJson(Map<String, dynamic> json) {
    return WhoPartnerUpdatedModel(
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
