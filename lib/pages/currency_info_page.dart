import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poo_coin_bsc_calculator/models/currency_info.dart';
import 'package:poo_coin_bsc_calculator/utils/colors.dart';
import 'package:poo_coin_bsc_calculator/utils/consts.dart';
import 'package:poo_coin_bsc_calculator/widgets/asset_chart.dart';

class CurrencyInfoPage extends StatelessWidget {
  final CurrencyInfo currencyInfo;

  const CurrencyInfoPage({
    super.key,
    required this.currencyInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          currencyInfo.symbol,
          style: TextStyle(color: kTextColor, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            FontAwesomeIcons.arrowLeftLong,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: pageSize.height * 0.01),
            Column(
              children: [
                Image.network(
                  currencyInfo.logoUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: pageSize.height * 0.01),
                Text(
                  currencyInfo.name,
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: pageSize.height * 0.02),
                Text(
                  formatLargeNumber(currencyInfo.cointPrice ?? 0),
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: pageSize.height * 0.25,
              child: AssetPriceChart(lineColor: kPrimaryColor),
            ),
            SizedBox(
              height: pageSize.height * 0.02,
              width: pageSize.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                currencyInfo.description,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: pageSize.height * 0.02,
              width: pageSize.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: pageSize.height * 0.03),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tags",
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: pageSize.height * 0.02),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      for (var tag in currencyInfo.tags.take(15))
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: kPrimaryColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: pageSize.height * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
