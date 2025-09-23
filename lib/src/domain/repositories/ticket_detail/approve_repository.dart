import '../../either.dart';
import '../../enums.dart';

abstract class ApproveRepository {
  Future<Either<GeneralFailure, int>> approve(
    int fkMaintenance,
    int finishByPartner,
    String evidence,
    String evidencePhoto,
    String evidencePhoto360,
  );
}
