import '../../../data/models/image/image_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class ImageRepository {
  Future<Either<GeneralFailure, String>> getImage(
      String uuid, String uuidapp, String name, String type);
}
