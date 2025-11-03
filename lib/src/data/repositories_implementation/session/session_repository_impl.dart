import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/session/session_repository.dart';
import '../../models/authentication/login_response_model.dart';
import '../../services/remote/session/session_service.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionService _sessionService;

  SessionRepositoryImpl({required SessionService sessionService})
      : _sessionService = sessionService;

  @override
  Future<Either<GeneralFailure, LoginResponseModel>> isSessionActive(
      String mobileUuid, String firebaseToken) {
    return _sessionService.getSession(mobileUuid, firebaseToken);
  }
}
