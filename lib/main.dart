import 'package:flutter/material.dart';
// import 'package:poo_coin_bsc_calculator/pages/onboarding_page.dart';
import 'package:poo_coin_bsc_calculator/pages/url_page.dart';
import 'package:poo_coin_bsc_calculator/utils/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    pageSize = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Inter"),
      home: const UrlScreen(url: "https://poocoin.app/"),
    );
  }
}
