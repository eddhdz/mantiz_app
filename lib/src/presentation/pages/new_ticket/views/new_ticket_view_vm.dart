import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';
import '../../../global/colors.dart';

class NewTicketViewVM with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  File _evidence = File('');
  File get evidence => _evidence;

  Color _evidenceColor = greenPrincipal;
  Color get evidenceColor => _evidenceColor;

  String _base64Image = '';
  String get base64Image => _base64Image;

  List<CustomerModel> _customers = [];
  List<CustomerModel> get customers => _customers;

  CustomerModel? _selectedCustomer;
  CustomerModel? get selectedCustomer => _selectedCustomer;

  List<BranchOfficeModel> _branchs = [];
  List<BranchOfficeModel> get branchs => _branchs;

  BranchOfficeModel? _selectedBranch;
  BranchOfficeModel? get selectedBranch => _selectedBranch;

  Future<void> loadCustomer() async {
    _isLoading = true;
    notifyListeners();

    _customers = [];
    for (var i = 0; i <= 3; i++) {
      CustomerModel cus = CustomerModel(
          id: i,
          fkPartner: i + 5,
          partner: 'gamesa$i',
          fkCustomer: 10,
          customer: 'soy Gamesa$i');

      _customers.add(cus);
    }

    _selectedCustomer = _customers[0];
    _isLoading = false;
    notifyListeners();
  }

  Future<void> customerSelectedAction(CustomerModel customer) async {
    _selectedCustomer = customer;
    notifyListeners();

    var a = 1000;
  }

  Future<void> loadSucursal() async {
    _isLoading = true;
    notifyListeners();

    _branchs = [];
    for (int i = 0; i <= 3; i++) {
      BranchOfficeModel branch = BranchOfficeModel(
          id: i,
          fkSubcompany: i + 20,
          description: 'Soy el branch $i',
          location: '100.25678',
          latitud: '-45.876',
          longitud: '8.873645',
          imagen: null,
          clave: '00000$i',
          subcompany: 'alguna',
          uuidBO: 'lkuysfes8723kjhs$i');

      _branchs.add(branch);
    }

    _selectedBranch = _branchs[0];
    _isLoading = false;
  }

  Future<void> branchSelectedAction(BranchOfficeModel branch) async {
    _selectedBranch = branch;
    notifyListeners();

    var a = 1000;
  }
}
