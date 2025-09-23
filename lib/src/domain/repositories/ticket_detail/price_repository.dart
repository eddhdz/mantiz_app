import '../../either.dart';
import '../../enums.dart';

abstract class PriceRepository {
  Future<Either<GeneralFailure, int>> price(
      int fkMaintenance, int createdByPartner, double price);
}
