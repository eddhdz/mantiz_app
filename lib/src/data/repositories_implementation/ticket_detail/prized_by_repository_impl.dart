import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/prized_by_repository.dart';
import '../../models/ticket_detail/prized_by_response_model.dart';
import '../../services/remote/ticket_detail/prized_by_service.dart';

class PrizedByRepositoryImpl implements PrizedByRepository {
  final PrizedByService _prizedByService;

  PrizedByRepositoryImpl({required PrizedByService prizedByService})
      : _prizedByService = prizedByService;
  @override
  Future<Either<GeneralFailure, PrizedResponseModel>> getPrices(
      int fkMaintenance) {
    return _prizedByService.getPrices(fkMaintenance);
  }
}
