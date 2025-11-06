// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'map_web_stub.dart'
//     if (dart.library.html) 'map_web.dart'; // Conditional import

// class MapContainer extends StatelessWidget {
//   const MapContainer({super.key});

//   final double lat = 26.442184;
//   final double lng = 50.111445;

//   final String iframeUrl =
//       "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3572.4201146227606!2d50.1114445!3d26.442183699999998!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3e49fbfd92d5cd99%3A0x8d648ab984012265!2sTrendy%20Chef!5e0!3m2!1sen!2ssa!4v1756556452198!5m2!1sen!2ssa";

//   @override
//   Widget build(BuildContext context) {
//     if (kIsWeb) {
//       registerIFrameFactory('iframeElement', iframeUrl);

//       return SizedBox(
//         height: 250,
//         width: double.infinity,
//         child: HtmlElementView(viewType: 'iframeElement'),
//       );
//     } else {
//       final CameraPosition initialPosition = CameraPosition(
//         target: LatLng(lat, lng),
//         zoom: 15,
//       );

//       return SizedBox(
//         height: 250,
//         width: double.infinity,
//         child: GoogleMap(
//           initialCameraPosition: initialPosition,
//           markers: {
//             Marker(
//               markerId: const MarkerId('trendychef'),
//               position: LatLng(lat, lng),
//               infoWindow: const InfoWindow(title: 'Trendy Chef'),
//             )
//           },
//           zoomControlsEnabled: false,
//         ),
//       );
//     }
//   }
// }
