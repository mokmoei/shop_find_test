import 'dart:async';

import 'package:find_shop_test/feature/location_search/data/models/places_location_model.dart';
import 'package:find_shop_test/feature/location_search/data/repositories/location_search_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSearchProvider extends ChangeNotifier {
  final LocationSearchRepository locationSearchRepository;
  LocationSearchProvider(this.locationSearchRepository);

  final TextEditingController searchController = TextEditingController();
  GoogleMapController? mapController;

  PlaceModel? _currentPlaceModel;
  List<PlaceModel> placeLocation = [];
  Timer? _debounce;

  PlaceModel? get getCurrentPlaceModel => _currentPlaceModel;
  set setCurrentPlace(PlaceModel newPlace) {
    _currentPlaceModel = newPlace;
    notifyListeners();
  }

  Future<void> setCurrentPlaceSearch(PlaceModel newPlace) async {
    searchController.clear();
    placeLocation.clear();
    await mapController?.moveCamera(CameraUpdate.newLatLng(
      LatLng(newPlace.location.latitude, newPlace.location.longitude),
    ));
    setCurrentPlace = newPlace;
  }

  Future<void> getPlacesLocation(String textQuery) async {
    // delay search when lot of call this function
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _getPlacesLocation(textQuery);
    });
  }

  Future<void> _getPlacesLocation(String textQuery) async {
    if (textQuery.isEmpty) {
      placeLocation = [];
      notifyListeners();
      return;
    }
    try {
      placeLocation = await locationSearchRepository.getPlaces(textQuery);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
