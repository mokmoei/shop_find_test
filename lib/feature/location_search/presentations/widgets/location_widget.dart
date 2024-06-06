import 'package:find_shop_test/feature/location_search/data/models/places_location_model.dart';
import 'package:find_shop_test/feature/location_search/presentations/providers/location_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationWidget extends StatelessWidget {
  final List<PlaceModel> placeLocation;
  const LocationWidget({super.key, required this.placeLocation});

  @override
  Widget build(BuildContext context) {
    if (placeLocation.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
      itemCount: placeLocation.length,
      itemBuilder: (context, index) {
        final place = placeLocation[index];
        return GestureDetector(
          onTap: () {
            context.read<LocationSearchProvider>().setCurrentPlaceSearch(place);
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place.displayName.text,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                place.formattedAddress,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: Color(0xFFE7E7E7),
                  height: 1,
                  endIndent: 12,
                  indent: 12,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
