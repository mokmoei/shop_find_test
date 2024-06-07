import 'package:find_shop_test/feature/branch_search/data/models/shop_list_model.dart';
import 'package:find_shop_test/feature/branch_search/data/repositories/branch_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class BranchSearchProvider extends ChangeNotifier {
  final TextEditingController branchSearchController = TextEditingController();
  List<ShopModel> shopListData = [];
  List<ShopModel> shopListFilterData = [];

  Future<void> getShopList(Location myLocation) async {
    try {
      shopListData = await BranchRepository().getShops();
      shopListFilterData = sortShopsByDistance(myLocation, shopListData);
      shopListData = shopListFilterData = checkTimeClose(shopListFilterData);
    } catch (e) {
      debugPrint("BranchSearchProvider getShopList fail: $e");
      rethrow;
    }
    notifyListeners();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      shopListFilterData = shopListData
          .where((item) =>
              item.siteDesc.contains(query.toLowerCase()) ||
              item.siteTel.contains(query.toLowerCase()))
          .toList();
    } else {
      shopListFilterData = shopListData;
    }
    notifyListeners();
  }

  double distanceFromMyLocation(Location myLocation, Location location) {
    // todo: implement Google distance
    final distance = Geolocator.distanceBetween(
      myLocation.latitude,
      myLocation.longitude,
      location.latitude,
      location.longitude,
    );
    return distance / 1000;
  }

  // Return a list of location and corresponding distance from user
  List<ShopModel> sortShopsByDistance(
    Location myLocation,
    List<ShopModel> shops,
  ) {
    // make this an empty list by initializing with []
    List<ShopModel> locationListWithDistance = [];

    // associate location with distance
    for (var shop in shops) {
      final distance = distanceFromMyLocation(myLocation, shop.location);
      shop.distance = distance;
      locationListWithDistance.add(shop);
    }

    // sort by distance
    locationListWithDistance.sort((a, b) {
      final d1 = a.distance;
      final d2 = b.distance;
      if (d1 > d2) {
        return 1;
      } else if (d1 < d2) {
        return -1;
      } else {
        return 0;
      }
    });
    return locationListWithDistance;
  }

  List<ShopModel> checkTimeClose(List<ShopModel> shops) {
    final openList = [];
    final closeList = [];
    final date = DateTime.now();

    for (var shop in shops) {
      if (shop.isOpen(date)) {
        openList.add(shop);
      } else {
        closeList.add(shop);
      }
    }
    return [...openList, ...closeList];
  }
}
