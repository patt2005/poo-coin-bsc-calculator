import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poo_coin_bsc_calculator/pages/home_page.dart';
import 'package:poo_coin_bsc_calculator/utils/colors.dart';
import 'package:poo_coin_bsc_calculator/utils/consts.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: PageView(
        controller: _pageController,
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(color: kBackgroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: pageSize.height * 0.08),
                    Image.asset(
                      "assets/images/image1.png",
                      width: pageSize.height * 0.33,
                      height: pageSize.height * 0.33,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(height: pageSize.height * 0.05),
                    Text(
                      "Manage Your Portfolio",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: pageSize.height * 0.03),
                    const Text(
                      "Track your crypto investments with real-time updates and insights.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: pageSize.height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(7.5),
                            color: kPrimaryColor.withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(7.5),
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(7.5),
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                        ),
                      ),
                      onPressed: () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut);
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: pageSize.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(color: kBackgroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: pageSize.height * 0.08),
                    Image.asset(
                      "assets/images/image2.png",
                      width: pageSize.height * 0.33,
                      height: pageSize.height * 0.33,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(height: pageSize.height * 0.05),
                    Text(
                      "Analyze Market Trends",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: pageSize.height * 0.03),
                    const Text(
                      "View detailed charts and spot trends with advanced analytics.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: pageSize.height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(7.5),
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 60,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(7.5),
                            color: kPrimaryColor.withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(7.5),
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                        ),
                      ),
                      onPressed: () {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut);
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: pageSize.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(color: kBackgroundColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: pageSize.height * 0.08),
                    Image.asset(
                      "assets/images/image3.png",
                      width: pageSize.height * 0.33,
                      height: pageSize.height * 0.33,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(height: pageSize.height * 0.05),
                    Text(
                      "Stay Informed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: pageSize.height * 0.03),
                    const Text(
                      "Get alerts and recommendations to optimize your trading decisions.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: pageSize.height * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(7.5),
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(7.5),
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 60,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(7.5),
                            color: kPrimaryColor.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(kPrimaryColor),
                        padding: const WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: Text(
                        "Get started",
                        style: TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: pageSize.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
