import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/price_repository.dart';
import '../../services/remote/ticket_detail/price_service.dart';

class PriceRepositoryImpl implements PriceRepository {
  final PriceService _priceService;

  PriceRepositoryImpl({required PriceService priceService})
      : _priceService = priceService;
  @override
  Future<Either<GeneralFailure, int>> price(
      int fkMaintenance, int createdByPartner, double price) {
    return _priceService.priceTicket(fkMaintenance, createdByPartner, price);
  }
}
