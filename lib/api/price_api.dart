import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:poo_coin_bsc_calculator/models/currency_info.dart';

class PriceApi {
  final dio = Dio();
  final String apiKey = "adadd437-d634-4ae5-89f5-511276616038";

  Future<List<CurrencyInfo>> getPrice() async {
    final headers = {
      "X-CMC_PRO_API_KEY": apiKey,
      "Accept": "application/json",
    };

    final queryParams = {
      "id":
          "1,1027,825,1839,5426,3408,52,74,11419,1958,2010,5805,5994,1975,1831,6636,6535,6535,3957,4943,2,20947,21794,22974,7083,24478,8916,20396,3773,28321,5690,328,1321,512,4847,26081,3897,10603,28752,7278,2280,3635,11840,4642,11841,7226,27075,3077,3794,3513"
    };

    try {
      final response = await dio.get(
        "https://pro-api.coinmarketcap.com/v2/cryptocurrency/info",
        options: Options(headers: headers),
        queryParameters: queryParams,
      );

      List<CurrencyInfo> currencyInfoList = [];

      for (var key in response.data["data"].keys) {
        currencyInfoList.add(CurrencyInfo.fromJson(response.data["data"][key]));
      }

      return currencyInfoList;
    } catch (e) {
      debugPrint("Caught an error: $e");
      return [];
    }
  }
}
