import '../../either.dart';
import '../../enums.dart';

abstract class AddMessageRepository {
  Future<Either<GeneralFailure, int>> addMessage(
    int ticketId,
    int userId,
    String message,
  );
}
