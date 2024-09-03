import 'package:mantiz/src/domain/models/branch_office_model.dart';

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
  Future<Either<GeneralFailure, List<BranchOfficeModel>>> loadBranchs(
      int fkCustomer) async {
    final branchResult = await _newTicketApi.loadBranchs(fkCustomer);

    return branchResult.when(
      (failure) {
        return Either.left(failure);
      },
      (branchs) {
        return Either.right(branchs);
      },
    );
  }

  @override
  Future<Either<GeneralFailure, List<CustomerModel>>> loadCustomers() async {
    final partner = await _storage.read(key: 'fkPartnerLicence');

    final newResult = await _newTicketApi.loadCustomers(int.parse(partner!));

    return newResult.when(
      (failure) {
        return Either.left(failure);
      },
      (customers) {
        return Either.right(customers);
      },
    );
  }
}
