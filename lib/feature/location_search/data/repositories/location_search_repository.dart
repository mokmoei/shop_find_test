import 'package:find_shop_test/core/network/http_client/map_http_client.dart';
import 'package:find_shop_test/feature/location_search/data/models/places_location_model.dart';

class LocationSearchRepository {
  Future<List<PlaceModel>> getPlaces(String textQuery) async {
    final res = await MapHttpClient().postData(
      'places:searchText',
      {"textQuery": textQuery},
    );

    final placeLocation = (res['places'] as List<dynamic>)
        .map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return placeLocation;
  }
}
