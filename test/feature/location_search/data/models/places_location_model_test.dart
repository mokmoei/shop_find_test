import 'package:find_shop_test/feature/location_search/data/models/places_location_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should can convert from json', () {
    final json = {
      "id": "ChIJRwObmj59HTERiuPyuuf1W3g",
      "formattedAddress":
          "24 Tambon Khu Khot, Amphoe Lam Luk Ka, Chang Wat Pathum Thani 12130, Thailand",
      "location": {"latitude": 13.9513452, "longitude": 100.6415731},
      "displayName": {"text": "คอนโดเดอะคิทท์3", "languageCode": "th"}
    };

    final placeModel = PlaceModel.fromJson(json);

    const placeModelExpect = PlaceModel(
      formattedAddress:
          '24 Tambon Khu Khot, Amphoe Lam Luk Ka, Chang Wat Pathum Thani 12130, Thailand',
      displayName: DisplayName(text: "คอนโดเดอะคิทท์3"),
      location: PlaceLocation(latitude: 13.9513452, longitude: 100.6415731),
    );

    expect(placeModel, placeModelExpect);
  });
}
