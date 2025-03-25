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
import 'package:owner/app/controller/login_controller.dart';
import 'package:owner/app/util/constance.dart';
import 'package:owner/app/util/theme.dart';
import 'package:country_picker/country_picker.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget getLanguages() {
    return PopupMenuButton(
      onSelected: (value) {},
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), child: IconButton(icon: const Icon(Icons.translate), color: ThemeProvider.appColor, onPressed: () {})),
      itemBuilder: (context) => AppConstants.languages
          .map(
            (e) => PopupMenuItem<String>(
              value: e.languageCode.toString(),
              onTap: () {
                var locale = Locale(e.languageCode.toString());
                Get.updateLocale(locale);
                Get.find<LoginController>().saveLanguage(e.languageCode);
              },
              child: Text(
                e.languageName.toString(),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (value) {
        return Stack(
          children: [
            Center(child: Container(width: double.infinity, decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/p7.jpg'))))),
            Scaffold(
              backgroundColor: ThemeProvider.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(backgroundColor: ThemeProvider.transparent, elevation: 0, actions: <Widget>[getLanguages()], automaticallyImplyLeading: false),
              bottomNavigationBar: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 450,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(color: ThemeProvider.whiteColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                  child: value.loginVersion == 0
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Row(children: [Text('Welcome'.tr, style: const TextStyle(color: ThemeProvider.blackColor, fontSize: 17))]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(children: [Text('Login With Your Account'.tr, style: const TextStyle(color: ThemeProvider.greyColor, fontSize: 13))]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: value.emailTextEditor,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeProvider.whiteColor,
                                    hintText: 'Email ID'.tr,
                                    hintStyle: const TextStyle(color: ThemeProvider.greyColor, fontSize: 12),
                                    contentPadding: const EdgeInsets.only(bottom: 8.0, top: 14.0, left: 20),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: ThemeProvider.appColor)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: ThemeProvider.appColor)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextField(
                                  controller: value.passwordTextEditor,
                                  obscureText: value.passwordVisible.value == true ? false : true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeProvider.whiteColor,
                                    suffixIcon: InkWell(
                                      onTap: () => value.togglePassword(),
                                      child: Icon(value.passwordVisible.value == false ? Icons.visibility : Icons.visibility_off, color: ThemeProvider.appColor),
                                    ),
                                    hintText: 'Password'.tr,
                                    hintStyle: const TextStyle(color: ThemeProvider.greyColor, fontSize: 12),
                                    contentPadding: const EdgeInsets.only(bottom: 8.0, top: 14.0, left: 20, right: 20),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: ThemeProvider.appColor)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: ThemeProvider.appColor)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => value.onForgot(),
                                    child: Text('Forgot Password?'.tr, style: const TextStyle(color: ThemeProvider.blackColor, fontSize: 13)),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: InkWell(
                                onTap: () => value.onLogin(),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                                  decoration: contentButtonStyle(),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('LOG IN'.tr, style: const TextStyle(color: ThemeProvider.whiteColor, fontSize: 17))]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [InkWell(onTap: () => value.onSignUp(), child: Text("Don't have an Account? Sign Up".tr, style: const TextStyle(color: ThemeProvider.greyColor, fontSize: 13)))],
                              ),
                            ),
                          ],
                        )
                      : value.loginVersion == 1
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(children: [Text('Welcome'.tr, style: const TextStyle(color: ThemeProvider.blackColor, fontSize: 17))]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(children: [Text('Login With Your Account'.tr, style: const TextStyle(color: ThemeProvider.greyColor, fontSize: 13))]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: ThemeProvider.appColor),
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              showCountryPicker(
                                                context: context,
                                                favorite: <String>['IN'],
                                                showPhoneCode: true,
                                                onSelect: (Country country) => value.updateCountryCode('+${country.phoneCode.toString()}'),
                                                countryListTheme: CountryListThemeData(
                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
                                                  inputDecoration: InputDecoration(
                                                    labelText: 'Search'.tr,
                                                    hintText: 'Start typing to search'.tr,
                                                    prefixIcon: const Icon(Icons.search),
                                                    border: OutlineInputBorder(borderSide: BorderSide(color: const Color(0xFF8C98A8).withValues(alpha: 0.2))),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [Text(value.countryCode.toString())],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 5),
                                          child: TextFormField(
                                            controller: value.mobileNo,
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: ThemeProvider.whiteColor,
                                              labelText: 'Mobile Number'.tr,
                                              hintStyle: const TextStyle(color: ThemeProvider.greyColor, fontSize: 12),
                                              contentPadding: const EdgeInsets.only(bottom: 8.0, top: 14.0, left: 20),
                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: ThemeProvider.appColor)),
                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: ThemeProvider.appColor)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: TextField(
                                      controller: value.passwordTextEditor,
                                      obscureText: value.passwordVisible.value == true ? false : true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: ThemeProvider.whiteColor,
                                        suffixIcon: InkWell(
                                          onTap: () => value.togglePassword(),
                                          child: Icon(value.passwordVisible.value == false ? Icons.visibility : Icons.visibility_off, color: ThemeProvider.appColor),
                                        ),
                                        hintText: 'Password'.tr,
                                        hintStyle: const TextStyle(color: ThemeProvider.greyColor, fontSize: 12),
                                        contentPadding: const EdgeInsets.only(bottom: 8.0, top: 14.0, left: 20, right: 20),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: ThemeProvider.appColor)),
                                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: ThemeProvider.appColor)),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [InkWell(onTap: () => value.onForgot(), child: Text('Forgot Password?'.tr, style: const TextStyle(color: ThemeProvider.blackColor, fontSize: 13)))],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: InkWell(
                                    onTap: () => value.loginWithPhonePassword(),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                                      decoration: contentButtonStyle(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text('LOG IN'.tr, style: const TextStyle(color: ThemeProvider.whiteColor, fontSize: 17))],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(onTap: () => value.onSignUp(), child: Text("Don't have an Account? Sign Up".tr, style: const TextStyle(color: ThemeProvider.greyColor, fontSize: 13))),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    children: [Text('Welcome'.tr, style: const TextStyle(color: ThemeProvider.blackColor, fontSize: 17))],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [Text('Login With Your Account'.tr, style: const TextStyle(color: ThemeProvider.greyColor, fontSize: 13))],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: ThemeProvider.appColor),
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              showCountryPicker(
                                                context: context,
                                                favorite: <String>['IN'],
                                                showPhoneCode: true,
                                                onSelect: (Country country) => value.updateCountryCode('+${country.phoneCode.toString()}'),
                                                countryListTheme: CountryListThemeData(
                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
                                                  inputDecoration: InputDecoration(
                                                    labelText: 'Search'.tr,
                                                    hintText: 'Start typing to search'.tr,
                                                    prefixIcon: const Icon(Icons.search),
                                                    border: OutlineInputBorder(borderSide: BorderSide(color: const Color(0xFF8C98A8).withValues(alpha: 0.2))),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [Text(value.countryCode.toString())],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 5),
                                          child: TextFormField(
                                            controller: value.mobileNo,
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: ThemeProvider.whiteColor,
                                              labelText: 'Mobile Number'.tr,
                                              hintStyle: const TextStyle(color: ThemeProvider.greyColor, fontSize: 12),
                                              contentPadding: const EdgeInsets.only(bottom: 8.0, top: 14.0, left: 20),
                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: ThemeProvider.appColor)),
                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: const BorderSide(color: ThemeProvider.appColor)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(onTap: () => value.onForgot(), child: Text('Forgot Password?'.tr, style: const TextStyle(color: ThemeProvider.blackColor, fontSize: 13))),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: InkWell(
                                    onTap: () => value.loginWithPhoneOTP(),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                                      decoration: contentButtonStyle(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [Text('LOG IN'.tr, style: const TextStyle(color: ThemeProvider.whiteColor, fontSize: 17))],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [InkWell(onTap: () => value.onSignUp(), child: Text("Don't have an Account? Sign Up".tr, style: const TextStyle(color: ThemeProvider.greyColor, fontSize: 13)))],
                                  ),
                                ),
                              ],
                            ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

contentButtonStyle() {
  return const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(100.0)),
    gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color.fromARGB(229, 52, 1, 255), Color.fromARGB(228, 111, 75, 255)]),
  );
}
