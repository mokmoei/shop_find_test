import 'package:find_shop_test/core/Icons/app_icons.dart';
import 'package:find_shop_test/core/font/font_style.dart';
import 'package:find_shop_test/core/theme/theme_app.dart';
import 'package:find_shop_test/core/utils/common_util.dart';
import 'package:find_shop_test/core/utils/date_time_utils.dart';
import 'package:find_shop_test/core/utils/navigator_utils.dart';
import 'package:find_shop_test/core/widgets/custom_button_widget.dart';
import 'package:find_shop_test/feature/branch_search/data/models/shop_list_model.dart';
import 'package:find_shop_test/feature/direction_site/presentations/screens/direction_site_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CardDetailSite extends StatefulWidget {
  final List<ShopModel> shopListData;
  const CardDetailSite({super.key, required this.shopListData});

  @override
  State<CardDetailSite> createState() => _CardDetailSiteState();
}

class _CardDetailSiteState extends State<CardDetailSite> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.shopListData.length,
      itemBuilder: (context, index) {
        final shopsData = widget.shopListData[index];

        var sellTime =
            '${AppDateTimeUtil.dateToTimeString(shopsData.siteOpenTime)} - ${AppDateTimeUtil.dateToTimeString(shopsData.siteCloseTime)}';
        final isOpen = shopsData.isOpen(DateTime.now());
        if (!isOpen) {
          sellTime = '($sellTime)';
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppIcons.locationBlue,
                      width: 32,
                      height: 32,
                    ),
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
                                  shopsData.siteDesc,
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
                                  '${shopsData.distance.toStringAsFixed(2)} กม.',
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
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      if (!isOpen)
                                        TextSpan(
                                          text: 'ปิด ',
                                          style: FontAppStyle.fontLarge
                                              .copyWith(color: Colors.red),
                                        ),
                                      TextSpan(
                                        text: sellTime,
                                        style: FontAppStyle.fontSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(color: Color(0xFFE7E7E7)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonWidget(
                        iconColor: ThemeApp.blue,
                        iconPath: AppIcons.phonCall,
                        textStyle: FontAppStyle.fontSmallBlue,
                        buttonColor: Colors.white,
                        borderColor: ThemeApp.blue,
                        buttonText: shopsData.siteTel,
                        onPressed: shopsData.isOpen(DateTime.now())
                            ? () {
                                final phoneNo = CommonUtil.convertPhoneNumber(
                                    shopsData.siteTel);
                                launchUrlString('tel://$phoneNo');
                              }
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomButtonWidget(
                        iconColor: Colors.white,
                        iconPath: AppIcons.map,
                        textStyle: FontAppStyle.fontSmallWhite,
                        buttonColor: ThemeApp.blue,
                        buttonText: "แผนที่สาขา",
                        onPressed: shopsData.isOpen(DateTime.now())
                            ? () {
                                NavigatorUtil.navigateScreen(
                                  context,
                                  DirectionSiteScreen(
                                    shop: shopsData,
                                  ),
                                );
                              }
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
