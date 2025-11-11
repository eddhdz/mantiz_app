class WhoCustomerUpdatedModel {
  int idProfile;
  String fullname;
  String email;
  String phone;
  String userToken;
  String typeUser;
  String typeRole;

  WhoCustomerUpdatedModel({
    required this.idProfile,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.userToken,
    required this.typeUser,
    required this.typeRole,
  });
}
