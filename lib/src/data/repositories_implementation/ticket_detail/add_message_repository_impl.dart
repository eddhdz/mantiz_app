import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/repositories/ticket_detail/add_message_repository.dart';
import '../../services/remote/ticket_detail/add_message_service.dart';

class AddMessageRepositoryImpl implements AddMessageRepository {
  final AddMessageService _addMessageService;

  AddMessageRepositoryImpl({required AddMessageService addMessageService})
      : _addMessageService = addMessageService;

  @override
  Future<Either<GeneralFailure, int>> addMessage(
      int fkMaintenance, int fkProfile, String message) {
    return _addMessageService.addMessage(fkMaintenance, fkProfile, message);
  }
}
