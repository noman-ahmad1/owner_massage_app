/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V8
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2025-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:owner/app/controller/salon_categories_controller.dart';
import 'package:owner/app/util/theme.dart';

class SalonCategoriesScreen extends StatefulWidget {
  const SalonCategoriesScreen({super.key});

  @override
  State<SalonCategoriesScreen> createState() => _SalonCategoriesScreen();
}

class _SalonCategoriesScreen extends State<SalonCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalonCategoriesController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 50,
            title: Text('Select Salon Categories'.tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: ThemeProvider.titleStyle),
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        for (var item in value.selectEditProfileList)
                          CheckboxListTile(
                            title: Text(item.name.toString()),
                            checkColor: Colors.white,
                            activeColor: ThemeProvider.appColor,
                            value: item.isChecked,
                            onChanged: (status) => value.updateStatus(status!, item.id as int),
                          ),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => value.updateCate(),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: ThemeProvider.greenColor, borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text('Update'.tr, style: const TextStyle(fontFamily: 'bold', color: ThemeProvider.whiteColor))),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => value.onBack(),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: ThemeProvider.redColor, borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text('Cancel'.tr, style: const TextStyle(fontFamily: 'bold', color: ThemeProvider.whiteColor))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
