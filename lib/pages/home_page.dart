import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:poo_coin_bsc_calculator/models/currency_info.dart';
import 'package:poo_coin_bsc_calculator/pages/currency_info_page.dart';
import 'package:poo_coin_bsc_calculator/utils/colors.dart';
import 'package:poo_coin_bsc_calculator/utils/consts.dart';
import 'package:poo_coin_bsc_calculator/widgets/coin_card_info.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<CurrencyInfo> _infoList = [];

  List<CurrencyInfo> _foundList = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CurrencyInfo? _selectedFromCurrency;
  CurrencyInfo? _selectedToCurrency;
  double _inputValue = 0;
  double? _convertedValue;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _calculateConversion() {
    if (_selectedFromCurrency != null &&
        _selectedToCurrency != null &&
        _inputValue > 0) {
      setState(() {
        _convertedValue = (_inputValue *
            (_selectedFromCurrency!.cointPrice ?? 0) /
            (_selectedToCurrency!.cointPrice ?? 1));
      });
    }
  }

  void _fetchData() async {
    _infoList = await priceApi.getPrice();
    List<String> coinIds = _infoList.map((e) => e.symbol).toList();
    String query = "";
    for (var id in coinIds) {
      query += "$id;";
    }
    query = query.substring(0, query.length - 1);
    await coinApi.fetchPrices(query, _infoList);
    _foundList = List.from(_infoList);
    setState(() {});
  }

  Widget _buildSelectedTab() {
    switch (_selectedIndex) {
      case 0:
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "BSC Charts",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: pageSize.height * 0.03),
              Container(
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white54,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        CupertinoIcons.search,
                        color: Colors.grey[400],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white54),
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              _foundList = List.from(_infoList);
                            } else {
                              _foundList = _infoList
                                  .where((c) => c.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            }
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter token name',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: pageSize.height * 0.03),
              Expanded(
                child: ListView.builder(
                  itemCount: _foundList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => CurrencyInfoPage(
                            currencyInfo: _foundList[index],
                          ),
                        ));
                      },
                      child: CoinCardInfo(currencyInfo: _foundList[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      case 1:
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white54),
                    ),
                    child: DropdownButton<CurrencyInfo>(
                      value: _selectedFromCurrency,
                      hint: const Text(
                        "Select from currency",
                        style: TextStyle(color: Colors.white),
                      ),
                      items: _infoList.map((CurrencyInfo currency) {
                        return DropdownMenuItem<CurrencyInfo>(
                          value: currency,
                          child: Row(
                            children: [
                              Image.network(
                                currency.logoUrl,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                currency.name,
                                style: TextStyle(color: kTextColor),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      dropdownColor: kBackgroundColor,
                      onChanged: (CurrencyInfo? newValue) {
                        setState(() {
                          _selectedFromCurrency = newValue;
                          _calculateConversion();
                        });
                      },
                      isExpanded: true,
                      underline: Container(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white54),
                    ),
                    child: DropdownButton<CurrencyInfo>(
                      value: _selectedToCurrency,
                      hint: const Text(
                        "Select to currency",
                        style: TextStyle(color: Colors.white),
                      ),
                      items: _infoList.map((CurrencyInfo currency) {
                        return DropdownMenuItem<CurrencyInfo>(
                          value: currency,
                          child: Row(
                            children: [
                              Image.network(
                                currency.logoUrl,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                currency.name,
                                style: TextStyle(color: kTextColor),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      dropdownColor: kBackgroundColor,
                      onChanged: (CurrencyInfo? newValue) {
                        setState(() {
                          _selectedToCurrency = newValue;
                          _calculateConversion();
                        });
                      },
                      isExpanded: true,
                      underline: Container(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white54),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Enter amount",
                        labelStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _inputValue = double.tryParse(value) ?? 0;
                          _calculateConversion();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_convertedValue != null)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Converted Value: ${_convertedValue!.toStringAsFixed(2)} ${_selectedToCurrency?.symbol}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      case 2:
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About BSC Calculator",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "BSC Calculator is your real-time cryptocurrency tracker and converter. Get accurate data for thousands of cryptocurrencies, view detailed coin information, and convert between currencies instantly.",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Key Features:",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "- Real-Time Market Data\n"
                  "- Cryptocurrency Conversion\n"
                  "- Detailed Coin Info\n"
                  "- Easy and User-Friendly Design",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Stay informed and make smart decisions with BSC Calculator!",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: kPrimaryColor,
        child: Column(
          children: [
            SizedBox(height: pageSize.height * 0.15),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: const [BoxShadow(blurRadius: 1)],
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                CupertinoIcons.square_grid_2x2,
                color: Colors.white,
                size: 60,
              ),
            ),
            SizedBox(height: pageSize.height * 0.05),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse(
                    "https://www.freeprivacypolicy.com/live/202176db-ba99-4655-8db1-f05e15ff4b4f"));
              },
              leading: const Icon(
                CupertinoIcons.shield,
                color: Colors.white,
              ),
              title: Text(
                "Privacy Policy",
                style: TextStyle(color: kTextColor),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse(
                    "https://www.termsfeed.com/live/cdaab51b-9cb4-4a9d-816e-8c6f94e4887b"));
              },
              leading: const Icon(
                CupertinoIcons.info,
                color: Colors.white,
              ),
              title: Text(
                "Terms of Use",
                style: TextStyle(color: kTextColor),
              ),
            ),
            ListTile(
              onTap: () async {
                final InAppReview inAppReview = InAppReview.instance;

                if (await inAppReview.isAvailable()) {
                  inAppReview.requestReview();
                }
              },
              leading: const Icon(
                CupertinoIcons.hand_thumbsup,
                color: Colors.white,
              ),
              title: Text(
                "Rate us",
                style: TextStyle(color: kTextColor),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // This will hide the keyboard when the user taps outside
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: pageSize.height * 0.02),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          CupertinoIcons.square_grid_2x2,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "BSC Calculator",
                      style: TextStyle(
                        color: kTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: const Text("About BSC Calculator"),
                              content: const Text(
                                "BSC Calculator provides real-time cryptocurrency tracking and conversion. Get the latest market data, view detailed coin information, and make informed financial decisions with ease.",
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.info,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: pageSize.height * 0.04),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: kBackgroundColor,
                    border: Border.all(color: Colors.white54),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                        child: Text(
                          "Charts",
                          style: TextStyle(
                            color: _selectedIndex == 0
                                ? Colors.white
                                : Colors.white30,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                        child: Text(
                          "Swap",
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? Colors.white
                                : Colors.white30,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                          width: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                        child: Text(
                          "About",
                          style: TextStyle(
                            color: _selectedIndex == 2
                                ? Colors.white
                                : Colors.white30,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: pageSize.height * 0.03),
                _buildSelectedTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
