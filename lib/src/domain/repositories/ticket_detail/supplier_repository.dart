import '../../../data/models/supplier_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class SupplierRepository {
  Future<Either<GeneralFailure, SupplierResponseModel>> getSuppliers(
      String fkPartnerLicence);
}
