import '../../../data/models/authentication/login_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class SessionRepository {
  Future<Either<GeneralFailure, LoginResponseModel>> isSessionActive(
    String mobileUuid,
    String firebaseToken,
  );
}
