import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../../domain/models/branch_office_model.dart';
import '../../../../../domain/models/maintenances_model.dart';
import '../../../../../domain/models/who_partner_created_model.dart';
import '../../../colors.dart';
import '../../texts/general_text.dart';

class ListViewHome extends StatefulWidget {
  const ListViewHome({super.key});

  @override
  State<ListViewHome> createState() => _ListViewHomeState();
}

class _ListViewHomeState extends State<ListViewHome> {
  final ScrollController _scrollController = ScrollController();
  List<MaintenancesModel> _allTickets = [];
  List<MaintenancesModel> _visibleTickets = [];
  int _itemsPerPage = 7;
  int _currentMaxIndex = 0;
  bool _isLoading = false;

  Future<void> _loadAllTickets() async {
    setState(() {
      _isLoading = true;
      _currentMaxIndex = 0;
      _allTickets = [];
      _visibleTickets = [];
    });

    for (var item = 1; item < 100; item++) {
      BranchOfficeModel branchOfficeModel = BranchOfficeModel(
          id: 1,
          fkSubcompany: 1,
          description: 'CMT Juan Escutia',
          location:
              'Manuel González Cossío 7500, Churubusco, 31120 Chihuahua, Chih.',
          latitud: '28.680731',
          longitud: '-106.115810',
          imagen: null,
          clave: 'M020',
          subcompany: 'Carne Mart',
          uuidBO: 'c4ca4238a0b923820dcc509a6f75849b');

      WhoPartnerCreatedModel whoPartnerCreatedModel = WhoPartnerCreatedModel(
          idProfile: 2,
          fullname: 'Enrique   Bachir Lazo',
          email: 'ebachir@ecosat.com.mx',
          phone: '6144275780',
          userToken: 'c81e728d9d4c2f636f067f89cc14862c',
          typeUser: 'Partner',
          typeRole: 'Administrador');

      MaintenancesModel model = MaintenancesModel(
          id: 5,
          fkTypeMaintenance: 1,
          fkPLC: null,
          fkCBO: 1,
          fkStatusMaintenance: 1,
          customer: 'Bafar',
          folio: item,
          viewFolio: '00000000000$item',
          description: 'Falla en puerta',
          area: 'Desarrolladores',
          reason: 'La puerta del patio no funciona',
          photoevidence: 'Un chingo de letras y números',
          status: 'Creado',
          type: 'Correctivo',
          createdAt: DateTime.parse('2024-08-06T12:58:20.000Z'),
          statusUpdateAt: null,
          branchOfficeModel: branchOfficeModel,
          whoPartnerCreatedModel: whoPartnerCreatedModel,
          whoCustomerCreatedModel: null,
          whoPartnerUpdatedModel: null,
          whoCustomerUpdatedModel: null);

      _allTickets.add(model);
    }

    setState(() {
      _visibleTickets = _allTickets.take(_itemsPerPage).toList();
      _currentMaxIndex = _itemsPerPage;
      _isLoading = false;
    });
  }

  void _loadMoreTickets() async {
    if (_currentMaxIndex >= _allTickets.length) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      final _nextItems =
          _allTickets.skip(_currentMaxIndex).take(_itemsPerPage).toList();
      _visibleTickets.addAll(_nextItems);
      _currentMaxIndex += _itemsPerPage;
      _isLoading = false;
    });
  }

  Widget cardTicket(MaintenancesModel maintenance) {
    return Wrap(children: <Widget>[
      Column(children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: SizedBox(
              child: Card(
            elevation: 7,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: blueExtraLightGlobalColor,
            child: Column(children: <Widget>[
              //! Folio ...
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(children: <Widget>[
                    const SizedBox(width: 5),
                    GeneralText(
                        mensaje: 'Folio:',
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 14,
                        weight: FontWeight.bold,
                        color: blackPanter),
                    GeneralText(
                        mensaje: maintenance.viewFolio,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 14,
                        weight: FontWeight.normal,
                        color: blackPanter),
                    const SizedBox(width: 5),
                  ])),

              //! Título ...
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(children: <Widget>[
                    const SizedBox(width: 5),
                    GeneralText(
                        mensaje: 'Título:',
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 14,
                        weight: FontWeight.bold,
                        color: blackPanter),
                    GeneralText(
                        mensaje: maintenance.description,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 14,
                        weight: FontWeight.normal,
                        color: blackPanter),
                    const SizedBox(width: 5),
                  ])),

              //! Cliente y estatus ...
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(children: <Widget>[
                    const SizedBox(width: 5),
                    GeneralText(
                        mensaje: 'Cliente:',
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 14,
                        weight: FontWeight.bold,
                        color: blackPanter),
                    GeneralText(
                        mensaje: maintenance.customer,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 14,
                        weight: FontWeight.normal,
                        color: blackPanter),
                    Expanded(child: Container()),
                    GeneralText(
                        mensaje: 'Estatus:',
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 14,
                        weight: FontWeight.bold,
                        color: blackPanter),
                    GeneralText(
                        mensaje: maintenance.status,
                        maxLines: 1,
                        overFlow: TextOverflow.ellipsis,
                        size: 14,
                        weight: FontWeight.normal,
                        color: blackPanter),
                    const SizedBox(width: 5),
                  ])),
            ]),
          )),
        )
      ])
    ]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadAllTickets();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _loadMoreTickets();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Stack(children: <Widget>[
      RefreshIndicator(
        color: blueLightGlobalColor,
        onRefresh: () => _loadAllTickets(),
        child: ListView.builder(
            controller: _scrollController,
            itemCount: _visibleTickets.length,
            itemBuilder: (BuildContext context, int index) {
              return Wrap(children: <Widget>[
                Column(children: <Widget>[
                  SizedBox(child: cardTicket(_visibleTickets[index])),
                ])
              ]);
            }),
      ),
      (_isLoading)
          ? Positioned(
              bottom: 40,
              left: screenSize.width * 0.5 - 30,
              child: const _LoadingIcon())
          : Container()
    ]);
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9), shape: BoxShape.circle),
      child: const CircularProgressIndicator(color: blueNeutralGlobalColor),
    );
  }
}
