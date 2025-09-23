import '../../../data/models/ticket_detail/suspended_by_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class SuspendedByRepository {
  Future<Either<GeneralFailure, SuspendResponseModel>> getSuspensionInfo(
      int fkMaintenance);
}
