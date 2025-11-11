class UserModel {
  String useruuid;
  String name;
  String email;
  String phone;

  UserModel({
    required this.useruuid,
    required this.name,
    required this.email,
    required this.phone,
  });

  UserModel.onInit()
      : useruuid = '',
        name = '',
        email = '',
        phone = '';
}
