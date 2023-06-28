import 'package:api_exam/Screen/AddData/View/AddDataScreen.dart';
import 'package:api_exam/Screen/Home/View/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
            name: '/',
            page: () => HomeScreen(),
          ),
          GetPage(
            name: '/addData',
            page: () => AddDataScreen(),
          ),
        ],
      ),
    ),
  );
}
