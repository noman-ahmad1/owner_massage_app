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
import 'package:owner/app/controller/review_controller.dart';
import 'package:owner/app/env.dart';
import 'package:owner/app/util/theme.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 50,
            title: Text('Review'.tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: ThemeProvider.titleStyle),
          ),
          body: value.apiCalled == false
              ? SkeletonListView()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(children: [Text('All Reviews'.tr, style: const TextStyle(color: ThemeProvider.blackColor, fontFamily: 'bold'))]),
                                ),
                                for (var item in value.ownerReviewsList)
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                        decoration: const BoxDecoration(
                                          border: Border(bottom: BorderSide(color: ThemeProvider.backgroundColor), top: BorderSide(color: ThemeProvider.backgroundColor)),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(100),
                                                    child: SizedBox.fromSize(
                                                      size: const Size.fromRadius(30),
                                                      child: FadeInImage(
                                                        image: NetworkImage('${Environments.apiBaseURL}storage/images/${item.user!.cover.toString()}'),
                                                        placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                                        imageErrorBuilder: (context, error, stackTrace) {
                                                          return Image.asset('assets/images/notfound.png', fit: BoxFit.cover, height: 30, width: 30);
                                                        },
                                                        fit: BoxFit.cover,
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: 120,
                                                                child: Text('${item.user!.firstName} ${item.user!.lastName}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15)),
                                                              ),
                                                              Text(
                                                                item.createdAt.toString(),
                                                                overflow: TextOverflow.ellipsis,
                                                                style: const TextStyle(color: ThemeProvider.greyColor, fontSize: 12),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(Icons.star, color: item.rating! >= 1 ? ThemeProvider.orangeColor : ThemeProvider.greyColor, size: 15),
                                                              Icon(Icons.star, color: item.rating! >= 2 ? ThemeProvider.orangeColor : ThemeProvider.greyColor, size: 15),
                                                              Icon(Icons.star, color: item.rating! >= 3 ? ThemeProvider.orangeColor : ThemeProvider.greyColor, size: 15),
                                                              Icon(Icons.star, color: item.rating! >= 4 ? ThemeProvider.orangeColor : ThemeProvider.greyColor, size: 15),
                                                              Icon(Icons.star, color: item.rating! >= 5 ? ThemeProvider.orangeColor : ThemeProvider.greyColor, size: 15),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                              child: Text(item.notes.toString(), textAlign: TextAlign.start, style: const TextStyle(fontSize: 12)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
