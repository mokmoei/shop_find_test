import 'dart:convert';

import 'package:find_shop_test/feature/branch_search/data/models/shop_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class BranchRepository {
  Future<List<ShopModel>> getShops() async {
    try {
      // Todo: implement real API
      var input =
          await rootBundle.loadString("assets/json/shop_list_mockup.json");
      var data = json.decode(input.replaceAll("\n", "")) as List;
      return data
          .map((e) => ShopModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint("BranchRepository getShops fail: $e");
      rethrow;
    }
  }
}
