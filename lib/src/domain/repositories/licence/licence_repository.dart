import '../../../data/models/user_licence_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class LicenceRepository {
  Future<Either<GeneralFailure, UserLicenceResponseModel>> getUserLicence(
      String fkPartner);
}
