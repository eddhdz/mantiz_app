import '../../either.dart';
import '../../enums.dart';

abstract class LogoutRepository {
  Future<Either<GeneralFailure, int>> logout();
}
