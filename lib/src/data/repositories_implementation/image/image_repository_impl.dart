import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/image/image_repository.dart';
import '../../models/image/image_model.dart';
import '../../services/remote/images/images_service.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImagesService _imagesService;

  ImageRepositoryImpl({required ImagesService imagesService})
      : _imagesService = imagesService;

  @override
  Future<Either<GeneralFailure, String>> getImage(
      String uuid, String uuidapp, String name, String type) {
    return _imagesService.getImage(uuid, uuidapp, name, type);
    ;
  }
}
