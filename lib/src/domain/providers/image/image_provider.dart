import 'package:flutter/material.dart';
import 'package:mantiz/src/domain/enums.dart';
import 'package:mantiz/src/domain/repositories/image/image_repository.dart';

import '../../../data/models/image/image_model.dart';

class ImagesProvider extends ChangeNotifier {
  final ImageRepository _imageRepository;

  ImagesProvider({required ImageRepository imageRepository})
      : _imageRepository = imageRepository;

  // List<FileData>? _images;
  String? _imageBase64;
  DataStatus _status = DataStatus.initial;
  GeneralFailure? _errorMessage;

  // List<FileData>? get images => _images;
  String? get imageBase64 => _imageBase64;
  DataStatus get status => _status;
  GeneralFailure? get errorMessage => _errorMessage;

  Future<void> fetchImage(
      String? uuid, String? uuidapp, String? name, String? type) async {
    _status = DataStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result =
        await _imageRepository.getImage(uuid!, uuidapp!, name!, type!);
    result.when((failure) {
      _errorMessage = failure;
      _status = DataStatus.error;
    }, (responseModel) {
      _imageBase64 = responseModel;
      _status = DataStatus.loaded;
    });
    notifyListeners();
  }
}
