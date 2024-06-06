import 'package:find_shop_test/core/utils/common_util.dart';
import 'package:find_shop_test/feature/branch_search/data/models/shop_list_model.dart';
import 'package:find_shop_test/feature/direction_site/presentations/providers/direction_site_provider.dart';
import 'package:find_shop_test/feature/direction_site/presentations/widgets/card_deeplink.dart';
import 'package:find_shop_test/feature/direction_site/presentations/widgets/card_detail_address_widget.dart';
import 'package:find_shop_test/feature/direction_site/presentations/widgets/map_view_site_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DirectionSiteScreen extends StatefulWidget {
  final ShopModel shop;

  const DirectionSiteScreen({
    super.key,
    required this.shop,
  });

  @override
  State<DirectionSiteScreen> createState() => _DirectionSiteScreenState();
}

class _DirectionSiteScreenState extends State<DirectionSiteScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DirectionSiteProvider>(
      create: (_) => DirectionSiteProvider(),
      child: Consumer<DirectionSiteProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.shop.siteDesc,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Stack(
              children: [
                MapViewSite(
                  latitude: widget.shop.location.latitude,
                  longitude: widget.shop.location.longitude,
                ),
                const CardDetailAddress(),
                SafeArea(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CardDeepLink(
                        shop: widget.shop,
                        onSiteTelPressed: () {
                          final phoneNo = CommonUtil.convertPhoneNumber(
                            widget.shop.siteTel,
                          );
                          launchUrlString('tel://$phoneNo');
                        },
                        onDeepLinkPressed: () async {
                          await provider.openOnGoogleMapApp(
                            widget.shop.location.latitude,
                            widget.shop.location.longitude,
                          );
                        },
                      ),
                    ),
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
