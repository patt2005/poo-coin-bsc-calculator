import 'package:flutter/material.dart';
import 'package:poo_coin_bsc_calculator/models/currency_info.dart';
import 'package:poo_coin_bsc_calculator/utils/colors.dart';

class CoinCardInfo extends StatelessWidget {
  final CurrencyInfo currencyInfo;

  const CoinCardInfo({
    super.key,
    required this.currencyInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kBackgroundColor,
        border: Border.all(
          color: Colors.white54,
        ),
      ),
      child: Row(
        children: [
          Image.network(
            currencyInfo.logoUrl,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              currencyInfo.name,
              style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          const Spacer(),
          Text(
            currencyInfo.symbol,
            style: const TextStyle(
              color: Colors.white38,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
