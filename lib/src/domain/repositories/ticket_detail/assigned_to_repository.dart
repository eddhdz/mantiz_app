import '../../../data/models/ticket_detail/assigned_to_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class AssignedToRepository {
  Future<Either<GeneralFailure, AssignedToResponseModel>> getAssigned(
      String fkMaintenance);
}
