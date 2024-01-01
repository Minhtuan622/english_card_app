import 'package:english_card_app/values/app_colors.dart';
import 'package:english_card_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Container(
                child: const Text(
                    '“It is amazing how complete is the delusion that beauty is goodness.”'),
              ),
              Container(
                height: 600,
                margin: const EdgeInsets.only(top: 16),
                child: PageView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
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
                              child: Text('Beautiful', style: AppStyles.h2),
                            ),
                            Text(
                              '“Think of all the beauty still left around you and be happy.”',
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
                child: ListView.builder(itemBuilder: (contex, index){
                  return buildIndicator(isActive == 0, size);
                }),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          child: const Icon(Icons.refresh, color: AppColors.textGray),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size){
    return Container(
      width: isActive ? 100 : 30,
      height: 30,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : AppColors.grayColor
      ),
    );
  }
}
