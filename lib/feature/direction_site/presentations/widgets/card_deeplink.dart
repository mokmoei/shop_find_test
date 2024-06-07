import 'package:find_shop_test/core/Icons/app_icons.dart';
import 'package:find_shop_test/core/font/font_style.dart';
import 'package:find_shop_test/core/theme/theme_app.dart';
import 'package:find_shop_test/core/utils/date_time_utils.dart';
import 'package:find_shop_test/core/widgets/custom_button_widget.dart';
import 'package:find_shop_test/feature/branch_search/data/models/shop_list_model.dart';
import 'package:flutter/material.dart';

class CardDeepLink extends StatelessWidget {
  final ShopModel shop;
  final void Function() onSiteTelPressed;
  final void Function() onDeepLinkPressed;

  const CardDeepLink({
    super.key,
    required this.shop,
    required this.onSiteTelPressed,
    required this.onDeepLinkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black.withOpacity(0.12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text('สาขา :'),
                        ),
                        Expanded(
                          child: Text(
                            shop.siteDesc,
                            style: FontAppStyle.fontSmall,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('ระยะทางภายในรัศมี :'),
                        ),
                        Expanded(
                          child: Text(
                            '${shop.distance.toStringAsFixed(2)} กม.',
                            style: FontAppStyle.fontSmall,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text('เวลาเปิดปิดร้าน :'),
                        ),
                        Expanded(
                          child: Text(
                            '${AppDateTimeUtil.dateToTimeString(shop.siteOpenTime)} - ${AppDateTimeUtil.dateToTimeString(shop.siteCloseTime)}',
                            style: FontAppStyle.fontSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Color(0xFFE7E7E7)),
          Row(
            children: [
              Expanded(
                child: CustomButtonWidget(
                  iconColor: ThemeApp.blue,
                  borderColor: ThemeApp.blue,
                  iconPath: AppIcons.phonCall,
                  textStyle: FontAppStyle.fontSmallBlue,
                  buttonColor: Colors.white,
                  buttonText: shop.siteTel,
                  onPressed: onSiteTelPressed,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomButtonWidget(
                  iconPath: AppIcons.navigation,
                  textStyle: FontAppStyle.fontSmallWhite,
                  buttonText: "แผนที่สาขา",
                  onPressed: onDeepLinkPressed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
