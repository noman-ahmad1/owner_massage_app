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
import 'package:owner/app/controller/individual_cities_controller.dart';
import 'package:owner/app/util/theme.dart';

class IndividualCitiesScreen extends StatefulWidget {
  const IndividualCitiesScreen({super.key});

  @override
  State<IndividualCitiesScreen> createState() => _IndividualCitiesScreenState();
}

class _IndividualCitiesScreenState extends State<IndividualCitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndividualCitiesController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 50,
            title: Text('Select Cities'.tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: ThemeProvider.titleStyle),
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: value.cityList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, i) => Column(
                            children: [
                              ListTile(
                                visualDensity: const VisualDensity(vertical: -4),
                                horizontalTitleGap: 0,
                                leading: Radio(
                                  activeColor: ThemeProvider.appColor,
                                  value: value.cityList[i].id.toString(),
                                  groupValue: value.selectedCities,
                                  onChanged: (data) => value.saveCities(data.toString()),
                                ),
                                title: Text(value.cityList[i].name.toString()),
                              ),
                            ],
                          ),
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
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: ThemeProvider.greenColor, borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      onTap: () => value.updateCity(),
                      child: Center(
                        child: Text('Update'.tr, style: const TextStyle(fontFamily: 'bold', color: ThemeProvider.whiteColor)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: ThemeProvider.redColor, borderRadius: BorderRadius.circular(5)),
                    child: InkWell(
                      onTap: () => value.onBack(),
                      child: Center(
                        child: Text('Cancle'.tr, style: const TextStyle(fontFamily: 'bold', color: ThemeProvider.whiteColor)),
                      ),
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
