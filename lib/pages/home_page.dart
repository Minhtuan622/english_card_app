import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_card_app/pages/controll_page.dart';
import 'package:english_card_app/values/app_colors.dart';
import 'package:english_card_app/values/app_styles.dart';
import 'package:english_card_app/widgets/app_button.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:quoter/quoter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/english_today.dart';
import '../values/share_keys.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  int length = 0;
  late PageController pageController;
  late Quote randomQuote;

  List<EnglishToday> words = [];
  List<String> nounData = [];
  List<Quote> quotes = [];

  List<String> randomList(int length) {
    int i = 0;
    while (i < length) {
      String item = nouns[Random().nextInt(nouns.length)];
      randomQuote = const Quoter().getRandomQuote();
      if (nounData.contains(item) && quotes.contains(randomQuote)) {
        continue;
      } else {
        item = item.substring(0, 1).toUpperCase() + item.substring(1);
        nounData.add(item);
        quotes.add(randomQuote);
        i++;
      }
    }
    return nounData;
  }

  void getNouns() async {
    nounData.clear();
    quotes.clear();
    words.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    length = pref.getInt(ShareKeys.counter) ?? 5;
    List<String> rans = randomList(length);
    words = rans.map((e) => EnglishToday(noun: e)).toList();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.8);
    randomQuote = const Quoter().getRandomQuote();
    getNouns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: Text('English today',
            style: AppStyles.h4.copyWith(color: AppColors.textGray)),
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(Icons.menu, color: AppColors.textGray),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              height: 50,
              alignment: Alignment.center,
              child: Text(randomQuote.quotation.toString()),
            ),
            Container(
              height: 600,
              margin: const EdgeInsets.only(top: 16),
              child: PageView.builder(
                itemCount: words.length,
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 6, right: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 25, bottom: 25),
                              child: Text(words[index].noun.toString(),
                                  style: AppStyles.h3),
                            ),
                          ),
                          AutoSizeText(
                            quotes[index].quotation.toString(),
                            maxLines: 4,
                            style: AppStyles.h4.copyWith(
                                color: AppColors.textGray, letterSpacing: 1),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Text(
                                quotes[index].quotee.toString(),
                                style: AppStyles.h4.copyWith(
                                  color: AppColors.textGray,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 12,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
              alignment: Alignment.center,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return buildIndicator(index == currentIndex);
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.refresh, color: AppColors.textGray),
        onPressed: () {
          setState(() {
            getNouns();
          });
        },
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.lightBlue,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  'Your mind',
                  style: AppStyles.h3.copyWith(color: AppColors.textGray),
                ),
              ),
              AppButton(label: 'Favorites', onTap: () {}),
              AppButton(
                label: 'Your control',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ControlPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive) {
    return Container(
      width: isActive ? 100 : 30,
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : AppColors.grayColor,
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}
