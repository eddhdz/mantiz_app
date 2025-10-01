import 'dart:convert';
import 'dart:io';

import 'package:mantiz/src/data/models/device_model.dart';

import '../../../../data/models/photo_evidence_model.dart';
import '../../../../data/models/save_photo_model.dart';
import '../../../../domain/enums.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/repositories/new_ticket/new_ticket_repository.dart';
import '../../../global/colors.dart';
import '../photos/camera_gallery_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewTicketViewVM with ChangeNotifier {
  final formKey = GlobalKey<FormState>();

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

  List<DeviceModel> _devices = [];
  List<DeviceModel> get devices => _devices;

  DeviceModel? _selectedDevice;
  DeviceModel? get selectedDevice => _selectedDevice;

  List<CustomerModel> _customers = [];
  List<CustomerModel> get customers => _customers;

  CustomerModel? _selectedCustomer;
  CustomerModel? get selectedCustomer => _selectedCustomer;

  List<BranchOfficeModel> _branchs = [];
  List<BranchOfficeModel> get branchs => _branchs;

  BranchOfficeModel? _selectedBranch;
  BranchOfficeModel? get selectedBranch => _selectedBranch;

  PhotoEvidenceModel? _photoEvidenceModel;
  PhotoEvidenceModel? get photoEvidenceModel => _photoEvidenceModel;

  bool _finishSaveTicket = false;
  bool get finishSaveTicket => _finishSaveTicket;

  bool _finishSavePhoto = false;
  bool get finishSavePhoto => _finishSavePhoto;

  String _title = '';
  String _description = '';
  String _area = '';

  Future<void> vmInit() async {
    _isLoading = false;
    _evidence = null;
    _evidenceColor = greenPrincipal;
    _base64Image = '';
    _rutaImage = '';
    _finishSaveTicket = false;
    _finishSavePhoto = false;

    notifyListeners();
  }

  Future<void> goToCamera() async {
    String? path = await CameraGalleryService().takePhoto();
    if (path != null) {
      _evidence = File(path);
      final bytes = await _evidence!.readAsBytes();

      _base64Image = base64Encode(bytes);
      _evidenceColor = orangePrincipal;

      notifyListeners();
    }
  }

  Future<void> selectImage() async {
    String? path = await CameraGalleryService().selectPhoto();
    if (path != null) {
      _evidence = File(path);
      final bytes = await _evidence!.readAsBytes();

      _base64Image = base64Encode(bytes);
      _evidenceColor = orangePrincipal;

      notifyListeners();
    }
  }

  Future<void> savePhoto(BuildContext context) async {
    _isLoading = true;
    _finishSavePhoto = false;
    notifyListeners();

    SavePhotoModel photo = SavePhotoModel(
      uuidapp: '97b290acab82d5937fb87a28b06181a3',
      uuid: null,
      name: '.jpeg',
      type: 'JPEG',
      url: null,
      im64: _base64Image,
      createdAt: DateTime.now(),
    );

    final result = await Provider.of<NewTicketRepository>(context, listen: false).savePhoto(photo);

    result.when((failure) {
      final message = {
        GeneralFailure.noData: 'No information',
        GeneralFailure.unknown: 'Error',
        GeneralFailure.network: 'No Internet',
        GeneralFailure.clientError: 'Client side connection failure',
        GeneralFailure.serverError: 'Server side connection failure',
      }[failure];

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
    }, (photo) async {
      if (photo.uuid.isNotEmpty) {
        _photoEvidenceModel = photo;
        _finishSavePhoto = true;

        notifyListeners();
      }
    });
  }

  Future<void> saveTicket(BuildContext context) async {
    _isLoading = true;
    _finishSaveTicket = false;
    notifyListeners();

    SaveTicketModel ticket = SaveTicketModel(
        id: 0,
        fkTypeMaintenance: 1,
        fkPCL: _selectedCustomer!.id,
        fkCBO: _selectedBranch!.id,
        fkStatusMaintenance: 1,
        fkCustomerBranchofficeDevice: _selectedDevice!.id,
        folio: 0,
        description: _title,
        area: _area,
        reason: _description,
        photoevidence: jsonEncode(_photoEvidenceModel),
        createdAt: DateTime.now(),
        createdByPartner: null,
        createdByCustomer: null);

    final result = await Provider.of<NewTicketRepository>(context, listen: false).saveTicket(ticket);

    result.when((failure) {
      final message = {
        GeneralFailure.noData: 'No information',
        GeneralFailure.unknown: 'Error',
        GeneralFailure.network: 'No Internet',
        GeneralFailure.clientError: 'Client side connection failure',
        GeneralFailure.serverError: 'Server side connection failure',
      }[failure];

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
    }, (guardado) async {
      if (guardado) {
        _finishSaveTicket = true;

        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No se pudo determinar por quien fue creado el ticket <Partner, Supplier o Customer>')));
      }
    });
  }

  Future<void> loadCustomer(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _customers = [];
    final result = await Provider.of<NewTicketRepository>(context, listen: false).loadCustomers();

    result.when((failure) {
      final message = {
        GeneralFailure.noData: 'No information',
        GeneralFailure.unknown: 'Error',
        GeneralFailure.network: 'No Internet',
        GeneralFailure.clientError: 'Client side connection failure',
        GeneralFailure.serverError: 'Server side connection failure',
      }[failure];

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
    }, (customers) {
      _customers = customers;
    });

    _selectedCustomer = (_customers.isNotEmpty) ? _customers[0] : null;

    //! Cargamos sucursales correspondientes al cliente seleccionado ...
    if (_selectedCustomer != null) {
      if (!context.mounted) return;
      await loadSucursal(context, _selectedCustomer!);
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> customerSelectedAction(BuildContext context, CustomerModel customer) async {
    _selectedCustomer = customer;

    //! Cargamos sucursales correspondientes al cliente seleccionado ...
    if (_selectedCustomer != null) {
      await loadSucursal(context, _selectedCustomer!);
    }
  }

  Future<void> loadSucursal(BuildContext context, CustomerModel customer) async {
    _isLoading = true;
    notifyListeners();

    _branchs = [];
    final result = await Provider.of<NewTicketRepository>(context, listen: false).loadBranchs(customer.fkCustomer);

    result.when((failure) {
      final message = {
        GeneralFailure.noData: 'No information',
        GeneralFailure.unknown: 'Error',
        GeneralFailure.network: 'No Internet',
        GeneralFailure.clientError: 'Client side connection failure',
        GeneralFailure.serverError: 'Server side connection failure',
      }[failure];

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
    }, (branchs) {
      _branchs = branchs;
    });

    _selectedBranch = (_branchs.isNotEmpty) ? _branchs[0] : null;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> branchSelectedAction(BuildContext context, BranchOfficeModel branch) async {
    _selectedBranch = branch;

    //! Cargamos dispositivos correspondientes a la sucursal seleccionada ...
    if (_selectedBranch != null) {
      await loadDevices(context, _selectedBranch!);
    }
  }

  Future<void> loadDevices(BuildContext context, BranchOfficeModel branch) async {
    _isLoading = true;
    notifyListeners();

    _devices = [];
    final result = await Provider.of<NewTicketRepository>(context, listen: false).loadDevices(branch.id);

    result.when((failure) {
      final message = {
        GeneralFailure.noData: 'No information',
        GeneralFailure.unknown: 'Error',
        GeneralFailure.network: 'No Internet',
        GeneralFailure.clientError: 'Client side connection failure',
        GeneralFailure.serverError: 'Server side connection failure',
      }[failure];

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message!)));
    }, (devices) {
      _devices = devices;
    });

    _selectedDevice = _devices.isNotEmpty ? _devices[0] : null;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deviceSelectedAction(DeviceModel device) async {
    _selectedDevice = device;
    notifyListeners();
  }

  String? validatorDevice(DeviceModel? device) {
    if (device == null) {
      return 'Debe seleccionar al menos un equipo en pantalla';
    }

    return null;
  }

  String? validatorBranch(BranchOfficeModel? branch) {
    if (branch == null) {
      return 'Debe seleccionar al menos una sucursal en pantalla';
    }

    return null;
  }

  String? validatorCustomer(CustomerModel? customer) {
    if (customer == null) {
      return 'Debe seleccionar al menos un cliente en pantalla';
    }

    return null;
  }

  String? generalValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo debe tener información';
    }

    return null;
  }

  void onTitleChange(String value) {
    _title = value;
  }

  void onDescriptionChange(String value) {
    _description = value;
  }

  void onAreaChange(String value) {
    _area = value;
  }
}
