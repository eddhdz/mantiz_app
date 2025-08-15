import '../../either.dart';
import '../../enums.dart';

abstract class AddMessageRepository {
  Future<Either<GeneralFailure, int>> addMessage(
    int fkMaintenance,
    int fkProfile,
    String message,
  );
}
