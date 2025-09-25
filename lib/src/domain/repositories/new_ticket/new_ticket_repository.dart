import '../../../data/models/branch_office_model.dart';
import '../../../data/models/customer_model.dart';
import '../../../data/models/device_model.dart';
import '../../../data/models/photo_evidence_model.dart';
import '../../../data/models/save_photo_model.dart';
import '../../../data/models/save_ticket_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class NewTicketRepository {
  Future<Either<GeneralFailure, List<DeviceModel>>> loadDevices(int fkCBO);

  Future<Either<GeneralFailure, List<CustomerModel>>> loadCustomers();

  Future<Either<GeneralFailure, List<BranchOfficeModel>>> loadBranchs(int fkCustomer);

  Future<Either<GeneralFailure, bool>> saveTicket(SaveTicketModel ticket);

  Future<Either<GeneralFailure, PhotoEvidenceModel>> savePhoto(SavePhotoModel photo);
}
