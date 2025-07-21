import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/models/models.dart';
import '../../../domain/repositories/new_ticket/new_ticket_repository.dart';
import '../../services/remote/new_ticket/new_ticket_api.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NewTicketRepositoryImpl implements NewTicketRepository {
  final FlutterSecureStorage _storage;
  final NewTicketApi _newTicketApi;

  NewTicketRepositoryImpl(this._newTicketApi, this._storage);

  @override
  Future<Either<GeneralFailure, bool>> saveTicket(SaveTicketModel model) async {
    final allStorage = await _storage.readAll();

    //! En este punto nos falta saber si el ticket fue creado por un <Partner> o un <customer> ...
    List<String> keys = ['Partner', 'Supplier', 'Customer'];
    String? target;
    int? valor;

    for (var key in keys) {
      if (allStorage.containsKey(key)) {
        target = key;
        valor = int.parse(allStorage[target].toString());

        break;
      }
    }

    if (target == 'Partner') {
      model.createdByPartner = valor;
    } else if (target == 'Customer') {
      model.createdByCustomer = valor;
    } else {
      return Either.right(false);
    }

    final saveResult = await _newTicketApi.saveTicket(model);

    return saveResult.when((failure) {
      return Either.left(failure);
    }, (save) {
      return Either.right(save);
    });
  }

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
