import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:poo_coin_bsc_calculator/models/currency_info.dart';

class CoinApi {
  final apiKey = "09EFBCAD-1738-4A83-A2ED-8F98E2F7A54F";
  final dio = Dio();

  Future<void> fetchPrices(String query, List<CurrencyInfo> infoList) async {
    final headers = {
      "X-CoinAPI-Key": apiKey,
      "Accept": "application/json",
    };

    try {
      final response = await dio.get(
        "https://rest.coinapi.io/v1/assets",
        options: Options(headers: headers),
        queryParameters: {"filter_asset_id": query},
      );

      final dataList = response.data;

      for (var info in infoList) {
        var foundData =
            dataList.where((e) => e["asset_id"] == info.symbol).first;
        info.cointPrice = foundData["price_usd"];
        info.dailyVolumeTrade = foundData["volume_1day_usd"];
      }
    } catch (e) {
      debugPrint("Caught an error: $e");
    }
  }
}
