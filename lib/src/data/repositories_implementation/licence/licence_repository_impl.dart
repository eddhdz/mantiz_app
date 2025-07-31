import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/licence/licence_repository.dart';
import '../../models/user_licence_response_model.dart';
import '../../services/remote/licence/licence_service.dart';

class LicenceRepositoryImpl implements LicenceRepository {
  final LicenceService _licenceService;

  LicenceRepositoryImpl(this._licenceService);
  @override
  Future<Either<GeneralFailure, UserLicenceResponseModel>> getUserLicence(
      String fkPartner) {
    return _licenceService.getPartnerLicence(fkPartner);
  }
}
