import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewSite extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapViewSite({
    required this.latitude,
    required this.longitude,
    super.key,
  });

  @override
  State<MapViewSite> createState() => _MapViewSiteState();
}

class _MapViewSiteState extends State<MapViewSite> {
  String mapLocation = "";

  // TextEditingController _textCustomerLocationController =
  //     TextEditingController();

  final Completer<GoogleMapController> _controller = Completer();
  final places = GoogleMapsPlaces();
  late final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 18,
  );
  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  // Future<Position> getUserCurrentLocation() async {
  //   LocationPermission permission;
  //   permission = await Geolocator.checkPermission();
  //   permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied) {
  //     //nothing
  //     debugPrint('nothing');
  //   }
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.low);
  //   debugPrint(position);
  //   return position;
  // }

  Future<void> setCurrentLocation() async {
    // getUserCurrentLocation().then((value) async {
    // debugPrint("${value.latitude} ${value.longitude}");

    PlacesSearchResponse response = await places.searchNearbyWithRadius(
        Location(lat: widget.latitude, lng: widget.longitude), 5000);

    debugPrint('address${response.results.length}');

    // marker added for current users location
    _markers.add(Marker(
      markerId: const MarkerId("2"),
      position: LatLng(widget.latitude, widget.longitude),
      infoWindow: const InfoWindow(
        title: 'My Current Location',
      ),
    ));

    // specified current users location
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 19,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    _getAddressFromCoordinates(LatLng(widget.latitude, widget.longitude));
    setState(() {});
    // }
  }

  Future<void> _getAddressFromCoordinates(LatLng coordinates) async {
    debugPrint('position move$coordinates');
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude,
      );

      if (placemarks.isNotEmpty) {
        geocoding.Placemark placemark = placemarks[0];
      }
    } catch (e) {
      debugPrint('Error retrieving address: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    setCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      // on below line setting camera position
      initialCameraPosition: _kGoogle,
      // onCameraMove: (CameraPosition newPosition) {
      //   setState(() {
      //     _kGoogle = newPosition;
      //   });
      // },
      // onCameraIdle: () {
      //   _getAddressFromCoordinates(_kGoogle.target);
      // },
      // on below line we are setting markers on the map
      markers: Set<Marker>.of(_markers),
      // on below line specifying map type.
      mapType: MapType.normal,
      // on below line setting user location enabled.
      myLocationEnabled: true,
      // on below line setting compass enabled.
      compassEnabled: true,
      // on below line specifying controller on map complete.
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        controller.showMarkerInfoWindow(const MarkerId("2"));
      },
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
    );
  }
}
