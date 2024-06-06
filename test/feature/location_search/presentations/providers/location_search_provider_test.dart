import 'package:find_shop_test/feature/location_search/data/models/places_location_model.dart';
import 'package:find_shop_test/feature/location_search/data/repositories/location_search_repository.dart';
import 'package:find_shop_test/feature/location_search/presentations/providers/location_search_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationSearchRepository extends Mock
    implements LocationSearchRepository {}

void main() {
  const placeModelExpect = PlaceModel(
    formattedAddress:
        '24 Tambon Khu Khot, Amphoe Lam Luk Ka, Chang Wat Pathum Thani 12130, Thailand',
    displayName: DisplayName(text: "คอนโดเดอะคิทท์3"),
    location: PlaceLocation(latitude: 13.9513452, longitude: 100.6415731),
  );

  group('get set currentPlaceModel', () {
    test('get set currentPlaceModel', () {
      /// setup
      final mockRepo = MockLocationSearchRepository();
      final locationSearchProvider = LocationSearchProvider(mockRepo);

      /// act
      locationSearchProvider.setCurrentPlace = placeModelExpect;

      /// verify
      expect(locationSearchProvider.getCurrentPlaceModel, placeModelExpect);
    });

    test('get set currentPlaceModel by search', () async {
      /// setup
      final mockRepo = MockLocationSearchRepository();
      final locationSearchProvider = LocationSearchProvider(mockRepo);
      locationSearchProvider.searchController.text = 'search text';

      /// act
      await locationSearchProvider.setCurrentPlaceSearch(placeModelExpect);

      /// verify
      expect(locationSearchProvider.getCurrentPlaceModel, placeModelExpect);
      expect(locationSearchProvider.searchController.text, '');
      expect(locationSearchProvider.placeLocation, []);
    });
  });

  group('getPlacesLocation', () {
    test('function getPlacesLocation should return correct', () async {
      /// set up
      final mockRepo = MockLocationSearchRepository();
      when(
        () => mockRepo.getPlaces(any()),
      ).thenAnswer((_) => Future.value([placeModelExpect]));
      final locationSearchProvider = LocationSearchProvider(mockRepo);

      /// act
      await locationSearchProvider.getPlacesLocation('text query test');
      await Future.delayed(const Duration(seconds: 1)); // wait debounce call

      /// verify
      expect(locationSearchProvider.placeLocation, [placeModelExpect]);
    });

    test('function getPlacesLocation should debounce', () async {
      /// set up
      final mockRepo = MockLocationSearchRepository();
      when(
        () => mockRepo.getPlaces(any()),
      ).thenAnswer((_) => Future.value([]));
      final locationSearchProvider = LocationSearchProvider(mockRepo);

      /// act
      // call 1 time
      await locationSearchProvider.getPlacesLocation('t');

      // call again test debounce / set return value
      when(
        () => mockRepo.getPlaces(any()),
      ).thenAnswer((_) => Future.value([placeModelExpect]));
      await locationSearchProvider.getPlacesLocation('text query test');
      await Future.delayed(const Duration(seconds: 1)); // wait debounce call

      /// verify
      expect(locationSearchProvider.placeLocation, [placeModelExpect]);
      // verify call api just 1 time
      verify(() => mockRepo.getPlaces(any())).called(1);
    });
  });
}
