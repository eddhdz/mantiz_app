// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class TicketMapWidget extends StatefulWidget {
//   final LatLng location;
//   final String address;

//   const TicketMapWidget({
//     super.key,
//     required this.location,
//     required this.address,
//   });

//   @override
//   State<TicketMapWidget> createState() => _TicketMapWidgetState();
// }

// class _TicketMapWidgetState extends State<TicketMapWidget> {
//   late GoogleMapController _mapController;
//   final Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     _addMarker();
//   }

//   void _addMarker() {
//     _markers.add(Marker(
//         markerId: const MarkerId('ticket location'),
//         position: widget.location,
//         infoWindow: InfoWindow(
//             title: 'Ubicación del servicio', snippet: widget.address)));
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       onMapCreated: _onMapCreated,
//       initialCameraPosition:
//           CameraPosition(target: widget.location, zoom: 15.0),
//       markers: _markers,
//     );
//   }
// }
