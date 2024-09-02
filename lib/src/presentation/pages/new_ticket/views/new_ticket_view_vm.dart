import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';
import '../../../global/colors.dart';
import '../photos/camera_gallery_service.dart';

class NewTicketViewVM with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  File? _evidence;
  File? get evidence => _evidence;

  Color _evidenceColor = greenPrincipal;
  Color get evidenceColor => _evidenceColor;

  String _base64Image = '';
  String get base64Image => _base64Image;

  String? _rutaImage;
  String? get rutaImage => _rutaImage;

  List<CustomerModel> _customers = [];
  List<CustomerModel> get customers => _customers;

  CustomerModel? _selectedCustomer;
  CustomerModel? get selectedCustomer => _selectedCustomer;

  List<BranchOfficeModel> _branchs = [];
  List<BranchOfficeModel> get branchs => _branchs;

  BranchOfficeModel? _selectedBranch;
  BranchOfficeModel? get selectedBranch => _selectedBranch;

  Future<void> vmInit() async {
    _isLoading = false;
    _evidence = null;
    _evidenceColor = greenPrincipal;
    _base64Image = '';
    _rutaImage = '';

    notifyListeners();
  }

  Future<void> goToCamera() async {
    String? path = await CameraGalleryService().takePhoto();
    if (path != null) {
      _evidence = File(path);
      final bytes = await _evidence!.readAsBytes();

      //! obtenemos la extensión de la imágen ...
      String extention = _evidence!.path.split('.').last;

      _base64Image = 'Data:image/$extention;base64,${base64Encode(bytes)}';
      _evidenceColor = orangePrincipal;

      notifyListeners();
    }
  }

  Future<void> selectImage() async {
    String? path = await CameraGalleryService().selectPhoto();
    if (path != null) {
      _evidence = File(path);
      final bytes = await _evidence!.readAsBytes();

      //! obtenemos la extensión de la imágen ...
      String extention = _evidence!.path.split('.').last;

      _base64Image = 'Data:image/$extention;base64,${base64Encode(bytes)}';
      _evidenceColor = orangePrincipal;

      notifyListeners();
    }
  }

  Future<void> loadCustomer() async {
    _isLoading = true;
    notifyListeners();

    _customers = [];
    for (var i = 0; i <= 3; i++) {
      CustomerModel cus = CustomerModel(
          id: i,
          fkPartner: i + 5,
          partner: 'gamesa-$i',
          fkCustomer: 10,
          customer: 'soy Gamesa-$i');

      _customers.add(cus);
    }

    _selectedCustomer = _customers[0];
    _isLoading = false;
    notifyListeners();
  }

  Future<void> customerSelectedAction(CustomerModel customer) async {
    _selectedCustomer = customer;
    notifyListeners();
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
          clave: '00000-$i',
          subcompany: 'alguna',
          uuidBO: 'lkuysfes8723kjhs-$i');

      _branchs.add(branch);
    }

    _selectedBranch = _branchs[0];
    _isLoading = false;
  }

  Future<void> branchSelectedAction(BranchOfficeModel branch) async {
    _selectedBranch = branch;
    notifyListeners();
  }
}
