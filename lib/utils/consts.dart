import 'package:flutter/material.dart';
import 'package:poo_coin_bsc_calculator/api/coin_api.dart';
import 'package:poo_coin_bsc_calculator/api/price_api.dart';

late Size pageSize;

final priceApi = PriceApi();
final coinApi = CoinApi();

String formatLargeNumber(double value) {
  // Define suffixes for large numbers
  List<String> suffixes = ['', 'K', 'M', 'B', 'T'];
  int magnitude = 0;

  while (value.abs() >= 1000 && magnitude < suffixes.length - 1) {
    magnitude++;
    value /= 1000.0;
  }

  // Format the value to show more decimal points for smaller numbers
  String formattedValue;
  if (value < 10) {
    formattedValue =
        value.toStringAsFixed(3); // More decimal points for values < 10
  } else if (value < 100) {
    formattedValue =
        value.toStringAsFixed(2); // Medium precision for values < 100
  } else {
    formattedValue = value
        .toStringAsFixed(1); // Default to one decimal place for larger values
  }

  return "$formattedValue${suffixes[magnitude]}";
}
