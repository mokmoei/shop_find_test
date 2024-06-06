import 'package:find_shop_test/core/Icons/app_icons.dart';
import 'package:find_shop_test/core/theme/theme_app.dart';
import 'package:find_shop_test/core/utils/navigator_utils.dart';
import 'package:find_shop_test/core/widgets/custom_button_widget.dart';
import 'package:find_shop_test/core/widgets/search_widget.dart';
import 'package:find_shop_test/feature/branch_search/presentations/screens/branch_search_screen.dart';
import 'package:find_shop_test/feature/location_search/presentations/providers/location_search_provider.dart';
import 'package:find_shop_test/feature/location_search/presentations/widgets/card_widget.dart';
import 'package:find_shop_test/feature/location_search/presentations/widgets/location_widget.dart';
import 'package:find_shop_test/feature/location_search/presentations/widgets/map_view_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({super.key});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationSearchProvider>(
      builder: (context, provider, _) {
        final currentLocation = provider.getCurrentPlaceModel;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'เลือกที่อยู่ส่งด่วน',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: Stack(
            children: [
              const CustomerListMapViewPage(),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: SearchFieldWidget(
                      onChanged: (value) => provider.getPlacesLocation(value),
                      controller: provider.searchController,
                      hint: "ค้นหาที่อยู่จัดส่งสินค้า",
                      prefix: Icons.search,
                    ),
                  ),
                  Expanded(
                    child: LocationWidget(
                      placeLocation: provider.placeLocation,
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: currentLocation != null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CardLocationSearchWidget(
                          textCard:
                              'ที่อยู่* (ตำบล, อำเภอ, จังหวัด, รหัสไปรษณีย์)',
                          iconCard: AppIcons.vector,
                          textLocationCard: currentLocation.formattedAddress,
                          iconLocationCard: AppIcons.location,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 12,
                        ),
                        child: CustomButtonWidget(
                          buttonText: "ยืนยันตำแหน่ง",
                          buttonColor: ThemeApp.blue,
                          onPressed: () {
                            NavigatorUtil.navigateScreen(
                              context,
                              const BranchSearchScreen(),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(child: Text("ไม่พบ Location")),
                  ),
          ),
        );
      },
    );
  }
}
