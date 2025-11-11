import 'dart:convert';
import 'dart:io';

import '../../../../data/models/device_model.dart';
import '../../../../data/models/failure_model.dart';
import '../../../../data/models/photo_evidence_model.dart';
import '../../../../data/models/save_photo_model.dart';
import '../../../../data/models/zone_model.dart';
import '../../../../domain/enums.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/repositories/new_ticket/new_ticket_repository.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:video_player/video_player.dart';

class NewTicketViewVM with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  //! Get's ...
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _finishSavePhoto = false;
  bool get finishSavePhoto => _finishSavePhoto;

  bool _finishSaveTicket = false;
  bool get finishSaveTicket => _finishSaveTicket;

  List<CustomerModel> _customers = [];
  List<CustomerModel> get customers => _customers;

  List<BranchOfficeModel> _branchs = [];
  List<BranchOfficeModel> get branchs => _branchs;

  List<ZoneModel> _zones = [];
  List<ZoneModel> get zones => _zones;

  List<DeviceModel> _devices = [];
  List<DeviceModel> get devices => _devices;

  List<FailureModel> _failures = [];
  List<FailureModel> get failures => _failures;

  CustomerModel? _selectedCustomer;
  CustomerModel? get selectedCustomer => _selectedCustomer;

  BranchOfficeModel? _selectedBranch;
  BranchOfficeModel? get selectedBranch => _selectedBranch;

  ZoneModel? _selectedZones;
  ZoneModel? get selectedZones => _selectedZones;

  DeviceModel? _selectedDevice;
  DeviceModel? get selectedDevice => _selectedDevice;

  FailureModel? _selectedFailures;
  FailureModel? get selectedFailures => _selectedFailures;

  XFile? _mediaFile;
  XFile? get mediaFile => _mediaFile;

  String? _base64;
  String? get base64 => _base64;

  String? _pathVideoImage;
  String? get pathVideoImage => _pathVideoImage;

  String? _typeFile;
  String? get typeFile => _typeFile;

  String? _nameFile;
  String? get nameFile => _nameFile;

  PhotoEvidenceModel? _photoEvidenceModel;
  PhotoEvidenceModel? get photoEvidenceModel => _photoEvidenceModel;

  File? _evidence;
  File? get evidence => _evidence;

  String _description = '';

  Future<void> vmInit() async {
    _mediaFile = null;
    _base64 = null;
    _pathVideoImage = null;
    _typeFile = null;
    _isLoading = false;
    _customers = [];
    _branchs = [];
    _zones = [];
    _devices = [];
    _failures = [];
    _evidence = null;
    _selectedCustomer = null;
    _selectedBranch = null;
    _selectedZones = null;
    _selectedDevice = null;
    _selectedFailures = null;
    _finishSavePhoto = false;
    _finishSaveTicket = false;

    notifyListeners();
  }

  Future<void> savePhoto(BuildContext context) async {
    _isLoading = true;
    _finishSavePhoto = false;
    notifyListeners();

    SavePhotoModel photo = SavePhotoModel(
      uuidapp: '97b290acab82d5937fb87a28b06181a3',
      uuid: null,
      name: _nameFile!,
      type: _typeFile!,
      url: '',
      im64: _base64!,
      createdAt: DateTime.now(),
    );

    var a = 1000;

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

    String title = '${_selectedBranch!.clave}-${_selectedZones!.zone}-${_selectedDevice!.code}';

    if (title.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('El título no se cargo en el proceso.')));
      }
    } else {
      SaveTicketModel ticket = SaveTicketModel(
          ticketId: 0,
          fkTypeMaintenance: 1,
          fkCBO: _selectedBranch!.branchofficeId,
          fkTypeStatusMaintenance: 1,
          fkZone: _selectedZones!.zoneId.toString(),
          folio: '0',
          title: title,
          reason: _description,
          photo: jsonEncode(photoEvidenceModel!.toJson()),
          // photo: photoEvidenceModel.toString(),
          createdat: DateTime.now(),
          createdby: 0,
          useruuid: '',
          devicefailuresids: _selectedFailures!.id.toString());

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
  }

  Future<void> _checkFileType(XFile file) async {
    String extension = p.extension(file.path).toLowerCase();
    _nameFile = _typeFile = null;

    switch (extension) {
      case '.jpg':
        _typeFile = 'image/jpg';
        _nameFile = '.jpg';
        break;
      case '.jpeg':
        _typeFile = 'image/jpeg';
        _nameFile = '.jpeg';
        break;
      case '.png':
        _typeFile = 'image/png';
        _nameFile = '.png';
        break;
      case '.gif':
        _typeFile = 'image/gif';
        _nameFile = '.gif';
        break;
      case '.mp4':
        _typeFile = 'video/mp4';
        _nameFile = '.mp4';
        break;
      case '.mov':
        _typeFile = 'video/mov';
        _nameFile = '.mov';
        break;
      case '.avi':
        _typeFile = 'video/avi';
        _nameFile = '.avi';
        break;
      case '.wmv':
        _typeFile = 'video/wmv';
        _nameFile = '.wmv';
        break;
      case '.mkv':
        _typeFile = 'video/mkv';
        _nameFile = '.mkv';
        break;
      default:
        _typeFile = 'no conocido';
    }

    print('Tipo: $_typeFile nombre: $_nameFile');

    notifyListeners();
  }

  Future<void> pickImage(BuildContext context) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _checkFileType(pickedFile);

        _convertToBase64(pickedFile);
      }
    } catch (ex) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('pickImage: ${ex.toString()}')));
      }
    }
  }

  Future<void> takePhoto(BuildContext context) async {
    try {
      final XFile? capturedFile = await _picker.pickImage(source: ImageSource.camera);
      if (capturedFile != null) {
        _checkFileType(capturedFile);

        _convertToBase64(capturedFile);
      }
    } catch (ex) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('takePhoto: ${ex.toString()}')));
      }
    }
  }

  Future<void> pickVideo(BuildContext context) async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: ImageSource.gallery, // o ImageSource.camera para grabar
        maxDuration: const Duration(seconds: 10),
      );

      if (pickedFile != null) {
        // Procesar video seleccionado
        final duration = await getVideoDuration(pickedFile.path);
        if (duration.inSeconds > 10) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('El video debe durar menos de 10 segundos')));
          }

          return;
        }

        _checkFileType(pickedFile);

        _convertToBase64(pickedFile);
      }
    } catch (ex) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('pickVideo: ${ex.toString()}')));
      }
    }
  }

  Future<void> recordVideo(BuildContext context) async {
    try {
      final XFile? recordedFile = await _picker.pickVideo(source: ImageSource.camera, maxDuration: const Duration(seconds: 10));
      if (recordedFile != null) {
        _checkFileType(recordedFile);

        _convertToBase64(recordedFile);
      }
    } catch (ex) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('pickVideo: ${ex.toString()}')));
      }
    }
  }

  Future<void> _convertToBase64(XFile file) async {
    _evidence = _pathVideoImage = _base64 = _mediaFile = null;

    final bytes = await File(file.path).readAsBytes();
    final base64String = base64Encode(bytes);

    _mediaFile = file;
    _base64 = base64String;
    _pathVideoImage = file.path;
    _evidence = File(file.path);

    notifyListeners();
  }

  Future<Duration> getVideoDuration(String videoPath) async {
    final VideoPlayerController controller = VideoPlayerController.file(File(videoPath));
    try {
      await controller.initialize();
      final duration = controller.value.duration;
      await controller.dispose();
      return duration;
    } catch (e) {
      await controller.dispose();
      return const Duration(seconds: 0);
    }
  }

  //! Load's ...
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
    }, (customers) async {
      _customers = customers;

      _selectedCustomer = (_customers.isNotEmpty) ? _customers[0] : null;

      //! Cargamos sucursales correspondientes al cliente seleccionado ...
      if (_selectedCustomer != null) {
        if (!context.mounted) return;
        await loadBranchOffice(context, _selectedCustomer!);
      } else {
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  Future<void> loadBranchOffice(BuildContext context, CustomerModel customerModel) async {
    _isLoading = true;
    _branchs = customerModel.branchoffices;
    notifyListeners();

    _selectedBranch = (_branchs.isNotEmpty) ? _branchs[0] : null;

    if (_selectedBranch != null) {
      if (!context.mounted) return;

      await loadZones(context, _selectedBranch!);
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadZones(BuildContext context, BranchOfficeModel branchModel) async {
    _isLoading = true;
    _zones = branchModel.zones;
    notifyListeners();

    _selectedZones = (_zones.isNotEmpty) ? _zones[0] : null;

    if (_selectedZones != null) {
      if (!context.mounted) return;

      await loadDevices(context, _selectedZones!);
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDevices(BuildContext context, ZoneModel zoneModel) async {
    _isLoading = true;
    _devices = zoneModel.devices;
    notifyListeners();

    _selectedDevice = (_devices.isNotEmpty) ? _devices[0] : null;

    if (_selectedDevice != null) {
      if (!context.mounted) return;

      await loadFailures(context, _selectedDevice!);
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadFailures(BuildContext context, DeviceModel deviceModel) async {
    _isLoading = true;
    _failures = deviceModel.failures;
    notifyListeners();

    _selectedFailures = (_failures.isNotEmpty) ? _failures[0] : null;

    _isLoading = false;
    notifyListeners();
  }

  //! Selected ...
  Future<void> customerSelectedAction(BuildContext context, CustomerModel customer) async {
    _selectedCustomer = customer;

    if (_selectedCustomer != null) {
      await loadBranchOffice(context, _selectedCustomer!);
    } else {
      notifyListeners();
    }
  }

  Future<void> branchSelectedAction(BuildContext context, BranchOfficeModel branch) async {
    _selectedBranch = branch;

    if (_selectedBranch != null) {
      await loadZones(context, _selectedBranch!);
    } else {
      notifyListeners();
    }
  }

  Future<void> zonesSelectedAction(BuildContext context, ZoneModel zone) async {
    _selectedZones = zone;

    if (_selectedZones != null) {
      await loadDevices(context, _selectedZones!);
    } else {
      notifyListeners();
    }
  }

  Future<void> deviceSelectedAction(BuildContext context, DeviceModel device) async {
    _selectedDevice = device;

    if (_selectedDevice != null) {
      await loadFailures(context, _selectedDevice!);
    } else {
      notifyListeners();
    }
  }

  Future<void> failureSelectedAction(BuildContext context, FailureModel failure) async {
    _selectedFailures = failure;
    notifyListeners();
  }

  //! Validator's ...
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

  //! Asignación de valores ...
  void onChangeDescription(String value) {
    _description = value;
  }
}
