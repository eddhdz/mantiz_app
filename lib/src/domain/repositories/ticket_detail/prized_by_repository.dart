import '../../../data/models/ticket_detail/prized_by_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class PrizedByRepository {
  Future<Either<GeneralFailure, PrizedResponseModel>> getPrices(
      int fkMaintenance);
}
