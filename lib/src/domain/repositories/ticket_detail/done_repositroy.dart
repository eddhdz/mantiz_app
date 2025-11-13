import '../../either.dart';
import '../../enums.dart';

abstract class DoneRepositroy {
  Future<Either<GeneralFailure, int>> done(
    int ticketID,
    int userId,
    String evidence,
    String evidencePhoto,
    String evidencePhoto360,
  );
}
