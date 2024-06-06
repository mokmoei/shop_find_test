import 'package:find_shop_test/core/widgets/search_widget.dart';
import 'package:find_shop_test/feature/branch_search/data/models/shop_list_model.dart';
import 'package:find_shop_test/feature/branch_search/presentations/providers/branch_search_provider.dart';
import 'package:find_shop_test/feature/branch_search/presentations/widgets/card_detail_site_widgets.dart';
import 'package:find_shop_test/feature/location_search/presentations/providers/location_search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BranchSearchScreen extends StatefulWidget {
  const BranchSearchScreen({super.key});

  @override
  State<BranchSearchScreen> createState() => _BranchSearchScreenState();
}

class _BranchSearchScreenState extends State<BranchSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final currentLocation =
        context.read<LocationSearchProvider>().getCurrentPlaceModel?.location;
    return ChangeNotifierProvider<BranchSearchProvider>(
      create: (context) => BranchSearchProvider()
        ..getShopList(Location(
          latitude: currentLocation?.latitude ?? 0,
          longitude: currentLocation?.longitude ?? 0,
        )),
      child: Consumer<BranchSearchProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'ค้นหาสาขา',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: SearchFieldWidget(
                    onChanged: (shopListData) {
                      provider.filterSearchResults(shopListData);
                    },
                    controller: provider.branchSearchController,
                    hint: "ค้นหาสาขา",
                    prefix: Icons.search,
                  ),
                ),
                Expanded(
                  child: CardDetailSite(
                    shopListData: provider.shopListFilterData,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
