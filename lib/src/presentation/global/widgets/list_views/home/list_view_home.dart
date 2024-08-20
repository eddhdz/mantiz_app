import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mantiz/main.dart';
import 'package:mantiz/src/presentation/global/widgets/buttons/button_box_horizontal.dart';

import '../../../../../domain/enums.dart';
import '../../../../../domain/models/models.dart';
import '../../../colors.dart';
import '../../texts/general_text.dart';

part 'card_list_view_home.dart';

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
    final result = await Injector.of(context).homeRepository.loadMaintenances();

    if (!mounted) {
      return;
    }

    result.when((failure) {
      final message = {
        GeneralFailure.noData: 'No information',
        GeneralFailure.unknown: 'Error',
        GeneralFailure.network: 'No Internet',
        GeneralFailure.clientError: 'Client side connection failure',
        GeneralFailure.serverError: 'Server side connection failure',
      }[failure];

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message!)));
    }, (maintenances) {
      setState(() {
        _isLoading = true;
        _currentMaxIndex = 0;
        _allTickets = [];
        _visibleTickets = [];
      });

      _allTickets = maintenances;

      setState(() {
        _visibleTickets = _allTickets.take(_itemsPerPage).toList();
        _currentMaxIndex = _itemsPerPage;
        _isLoading = false;
      });
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAllTickets();
    });

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
      (_allTickets.isEmpty)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    child: ButtonBoxHorizontal(buttons: [
                  FloatingButtonPropertiesModel(
                      icon: Icons.replay_outlined,
                      backGround: blueLightGlobalColor,
                      foreGround: whiteGlobalColor,
                      onPressed: () async {
                        await _loadAllTickets();
                      },
                      label: 'Recargar pantalla',
                      heroTag: 'btnAddTicket'),
                ]))
              ],
            )
          : RefreshIndicator(
              color: blueLightGlobalColor,
              onRefresh: () => _loadAllTickets(),
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
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
