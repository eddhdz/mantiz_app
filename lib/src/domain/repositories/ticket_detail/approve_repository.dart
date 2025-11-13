import '../../either.dart';
import '../../enums.dart';

abstract class ApproveRepository {
  Future<Either<GeneralFailure, int>> approve(
    int ticketId,
    int userId,
    String evidence,
    String evidencePhoto,
    String evidencePhoto360,
  );
}
