class FailureModel {
  int id;
  String description;

  FailureModel({required this.id, required this.description});

  FailureModel.onInit()
      : id = 0,
        description = '';
}
