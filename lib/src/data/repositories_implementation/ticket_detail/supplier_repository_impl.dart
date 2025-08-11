import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/supplier_repository.dart';
import '../../models/supplier_response_model.dart';
import '../../services/remote/ticket_detail/suppliers_service.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  final SuppliersService _suppliersService;

  SupplierRepositoryImpl({required SuppliersService suppliersService})
      : _suppliersService = suppliersService;
  @override
  Future<Either<GeneralFailure, SupplierResponseModel>> getSuppliers(
      String fkPartnerLicence) {
    return _suppliersService.getSuppliers(fkPartnerLicence);
  }
}
