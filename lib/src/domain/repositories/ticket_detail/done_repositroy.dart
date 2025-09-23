import '../../either.dart';
import '../../enums.dart';

abstract class DoneRepositroy {
  Future<Either<GeneralFailure, int>> done(
    int fkMaintenance,
    int doneByPartner,
    String evidence,
    String evidencePhoto,
    String evidencePhoto360,
  );
}
