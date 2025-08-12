import '../../../data/models/profile_response_model.dart';
import '../../either.dart';
import '../../enums.dart';

abstract class SupervisorRepository {
  Future<Either<GeneralFailure, ProfileResponseModel>> getSupervisors(
      String fkSBO);
}
