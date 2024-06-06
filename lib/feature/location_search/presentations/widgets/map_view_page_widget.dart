import 'dart:async';

import 'package:find_shop_test/feature/location_search/data/models/places_location_model.dart'
    as app;
import 'package:find_shop_test/feature/location_search/presentations/providers/location_search_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CustomerListMapViewPage extends StatefulWidget {
  const CustomerListMapViewPage({super.key});

  @override
  State<CustomerListMapViewPage> createState() =>
      _CustomerListMapViewPageState();
}

class _CustomerListMapViewPageState extends State<CustomerListMapViewPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final places = GoogleMapsPlaces();
  CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 18,
  );

  Future<Position> getUserCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      debugPrint('Permission denied');
      return Future.error('Location permissions are denied');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
  }

  void setCurrentLocation() {
    getUserCurrentLocation().then((value) async {
      debugPrint("${value.latitude} ${value.longitude}");

      PlacesSearchResponse response = await places.searchNearbyWithRadius(
          Location(lat: value.latitude, lng: value.longitude), 5000);

      debugPrint('address${response.results.length}');

      LatLng currentPosition = LatLng(value.latitude, value.longitude);
      _moveCameraToPosition(currentPosition);
      _getAddressFromCoordinates(currentPosition);
      setState(() {});
    });
  }

  Future<void> _moveCameraToPosition(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: position, zoom: 18),
    ));
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
        final placeMark = placemarks.first;
        final address =
            '${placeMark.street}, ${placeMark.locality}, ${placeMark.country}';
        final name = address;

        context.read<LocationSearchProvider>().setCurrentPlace = app.PlaceModel(
          displayName: app.DisplayName(text: name),
          formattedAddress: address,
          location: app.PlaceLocation(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude,
          ),
        );
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
    return Stack(
      children: [
        Consumer<LocationSearchProvider>(builder: (context, provider, _) {
          return GoogleMap(
            initialCameraPosition: _kGoogle,
            onCameraMove: (newPosition) => _kGoogle = newPosition,
            onCameraIdle: () => _getAddressFromCoordinates(_kGoogle.target),
            mapType: MapType.normal,
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              provider.mapController = controller;
            },
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
          );
        }),
        const Center(
          child: Icon(Icons.location_pin, size: 50, color: Colors.red),
        ),
      ],
    );
  }
}
