import 'dart:math';

import 'package:english_card_app/values/app_colors.dart';
import 'package:english_card_app/values/app_styles.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import '../models/english_today.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  late PageController pageController;

  List<EnglishToday> words = [];
  List<String> nounData = [];

  void getNouns() {
    int i = 0;
    while (i < 5) {
      String item = nouns[Random().nextInt(nouns.length)];
      if (nounData.contains(item)) {
        continue;
      } else {
        nounData.add(item);
        i++;
      }
    }
    words = nounData.map((e) => EnglishToday(noun: e)).toList();
  }

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.8);
    getNouns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: Text('English today',
            style: AppStyles.h4.copyWith(color: AppColors.textGray)),
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {},
          child: const Icon(Icons.menu, color: AppColors.textGray),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: const Text(
                  '“It is amazing how complete is the delusion that beauty is goodness.”'),
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
                              Icons.favorite,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 25, bottom: 25),
                            child: Text(words[index].noun.toString(),
                                style: AppStyles.h3),
                          ),
                          Text(
                            words[index].quote.toString(),
                            style: AppStyles.h3.copyWith(
                                color: AppColors.textGray, letterSpacing: 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Text(
                              '― Anne Frank',
                              style: AppStyles.h4.copyWith(
                                color: AppColors.textGray,
                                fontWeight: FontWeight.bold,
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
    );
  }

  Widget buildIndicator(bool isActive) {
    return Container(
      width: isActive ? 100 : 30,
      margin: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : AppColors.grayColor,
          borderRadius: BorderRadius.circular(14)),
    );
  }
}
