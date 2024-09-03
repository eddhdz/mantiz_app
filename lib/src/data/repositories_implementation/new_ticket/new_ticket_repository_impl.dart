import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/customer_model.dart';
import '../../../domain/repositories/new_ticket/new_ticket_repository.dart';
import '../../services/remote/new_ticket/new_ticket_api.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NewTicketRepositoryImpl implements NewTicketRepository {
  final FlutterSecureStorage _storage;
  final NewTicketApi _newTicketApi;

  NewTicketRepositoryImpl(this._newTicketApi, this._storage);

  @override
  Future<Either<GeneralFailure, List<CustomerModel>>> loadCustomers() async {
    final partner = await _storage.read(key: 'fkPartnerLicence');

    final newResult = await _newTicketApi.loadCustomers(int.parse(partner!));

    return newResult.when(
      (failure) {
        return Either.left(failure);
      },
      (maintenances) {
        return Either.right(maintenances);
      },
    );
  }
}
