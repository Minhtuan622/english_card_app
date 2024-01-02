import 'package:english_card_app/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/app_colors.dart';
import '../values/app_styles.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
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
          onTap: () async {
            Navigator.pop(context);
            SharedPreferences pref = await SharedPreferences.getInstance();
            await pref.setInt(ShareKeys.counter, sliderValue.toInt());
          },
          child:
              const Icon(Icons.keyboard_arrow_left, color: AppColors.textGray),
        ),
      ),
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Text(
              'How much a number word at once?',
              style: AppStyles.h5.copyWith(color: AppColors.textGray),
            ),
          ),
          const Spacer(),
          Center(
            child: Text(
              '${sliderValue.toInt()}',
              style: AppStyles.h1.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          Slider(
            value: sliderValue,
            min: 5,
            max: 50,
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.grayColor,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            },
          ),
          Center(
            child: Text(
              'Slide to set value',
              style: AppStyles.h5.copyWith(color: AppColors.textGray),
            ),
          ),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }
}
