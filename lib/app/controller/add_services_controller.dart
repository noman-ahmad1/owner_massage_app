/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V8
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2025-present initappz.
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owner/app/backend/api/handler.dart';
import 'package:owner/app/backend/parse/add_services_parse.dart';
import 'package:owner/app/controller/services_categories_controller.dart';
import 'package:owner/app/controller/services_controller.dart';
import 'package:owner/app/helper/router.dart';
import 'package:owner/app/util/theme.dart';
import 'package:owner/app/util/toast.dart';

class PricingOption {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController offController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  Map<String, dynamic> toJson() => {
    'price': priceController.text,
    'discount': discountController.text,
    'off': offController.text,
    'duration': durationController.text,
  };

  void dispose() {
    priceController.dispose();
    discountController.dispose();
    offController.dispose();
    durationController.dispose();
  }
}

class AddServicesController extends GetxController implements GetxService {
  final AddServicesParser parser;

  String title = 'Add Service'.tr;
  XFile? _selectedImage;

  List<String> gallery = ['', '', '', '', '', ''];
  List<PricingOption> pricingOptions = [PricingOption()];

  String selectedServicesName = '';
  String selectedServicesId = '';
  final nameTextEditor = TextEditingController();
  final descriptionsTextEditor = TextEditingController();
  int selectedStatus = 1;

  bool apiCalled = false;

  String cover = '';

  int serviceId = 0;
  String action = 'new';

  AddServicesController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    addNewPricingOption();

    if (Get.arguments[0] == 'edit') {
      action = 'edit';
      serviceId = Get.arguments[1] as int;
      debugPrint('service id --> $serviceId');
      getServiceById();
    } else {
      apiCalled = true;
    }
  }

  @override
  void onClose() {
    nameTextEditor.dispose();
    descriptionsTextEditor.dispose();
    for (var option in pricingOptions) {
      option.dispose();
    }
    super.onClose();
  }

  void addNewPricingOption() {
    pricingOptions.add(PricingOption());
    update();
  }

  void removePricingOption(int index) {
    pricingOptions[index].dispose();
    pricingOptions.removeAt(index);
    update();
  }

  void onSaveCategory(String id, String name) {
    selectedServicesId = id;
    selectedServicesName = name;
    debugPrint('got from service list');
    update();
  }

  Future<void> onSubmit() async {
    if (nameTextEditor.text.isEmpty ||
        selectedServicesId.isEmpty ||
        descriptionsTextEditor.text.isEmpty ||
        cover.isEmpty ||
        pricingOptions.any((option) =>
            option.priceController.text.isEmpty ||
            option.discountController.text.isEmpty ||
            option.durationController.text.isEmpty)) {
      showToast('All fields are required!');
      return;
    }

    Get.dialog(
      SimpleDialog(
        children: [
          Row(
            children: const [
              SizedBox(width: 30),
              CircularProgressIndicator(color: ThemeProvider.appColor),
              SizedBox(width: 30),
              Text("Please wait", style: TextStyle(fontFamily: 'bold')),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );

    var dataList = pricingOptions.map((option) => {
      "uid": parser.getUID(),
      "name": nameTextEditor.text,
      "cate_id": selectedServicesId,
      "duration": option.durationController.text,
      "price": option.priceController.text,
      "discount": option.discountController.text,
      "off": option.offController.text,
      "images": jsonEncode(gallery),
      "cover": cover,
      "extra_field": "NA",
      "status": selectedStatus,
      "descriptions": descriptionsTextEditor.text
    }).toList();

    var body = {"data": dataList};

    var response = await parser.onSubmit(body);
    Get.back();

    if (response.statusCode == 200) {
      Get.find<ServicesController>().getServices();
      successToast('Services Added!');
      onBack();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  void updateStatus(int status) {
    selectedStatus = status;
    update();
  }

  Future<void> getServiceById() async {
    var response = await parser.getServiceByID({"id": serviceId});
    apiCalled = true;
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      debugPrint(body.toString());
      cover = body['cover'];
      selectedServicesId = body['cate_id'].toString();
      nameTextEditor.text = body['name'];
      selectedServicesName = body['web_cates_data']['name'].toString();
      descriptionsTextEditor.text = body['descriptions'];
      selectedStatus = body['status'];

      if (pricingOptions.isEmpty) {
        addNewPricingOption();
      }

      pricingOptions[0].priceController.text = body['price'].toString();
      pricingOptions[0].discountController.text = body['discount'].toString();
      pricingOptions[0].offController.text = body['off'].toString();
      pricingOptions[0].durationController.text = body['duration'].toString();

      var imgs = jsonDecode(body['images']);
      gallery = [];
      imgs.forEach((element) {
        gallery.add(element.toString());
      });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> onUpdateService() async {
    await onSubmit();
  }

  void onRealPrice(String input, int index) {
    if (input != '' && pricingOptions[index].discountController.text != '') {
      double realPrice = double.tryParse(input) ?? 0;
      double discount = double.tryParse(pricingOptions[index].discountController.text) ?? 0;
      double off = realPrice - (realPrice * discount / 100);
      pricingOptions[index].offController.text = off.toStringAsFixed(2);
      update();
    }
  }

  void onDiscountPrice(String input, int index) {
    if (input != '' && pricingOptions[index].priceController.text != '') {
      double discount = double.tryParse(input) ?? 0;
      if (discount > 99) {
        pricingOptions[index].discountController.text = '99';
        showToast('Discount must be less than 100');
      }
      onRealPrice(pricingOptions[index].priceController.text, index);
    }
  }

  void percentage(double percent, double total, int index) {
    double sum = (total * percent) / 100;
    sum = double.parse((sum).toStringAsFixed(2));
    debugPrint(sum.toString());
    double realPrice = num.tryParse(pricingOptions[index].priceController.text)?.toDouble() ?? 0;
    pricingOptions[index].offController.text = (realPrice - sum).toString();
    update();
  }

  void onBack() {
    var context = Get.context as BuildContext;
    Navigator.of(context).pop(true);
  }

  void selectFromGallery(String kind) async {
    _selectedImage = await ImagePicker().pickImage(source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera, imageQuality: 25);
    update();
    if (_selectedImage != null) {
      Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(width: 30),
                const CircularProgressIndicator(color: ThemeProvider.appColor),
                const SizedBox(width: 30),
                SizedBox(child: Text("Please wait".tr, style: const TextStyle(fontFamily: 'bold'))),
              ],
            )
          ],
        ),
        barrierDismissible: false,
      );
      Response response = await parser.uploadImage(_selectedImage as XFile);
      Get.back();
      if (response.statusCode == 200) {
        _selectedImage = null;
        if (response.body['data'] != null && response.body['data'] != '') {
          dynamic body = response.body["data"];
          if (body['image_name'] != null && body['image_name'] != '') {
            cover = body['image_name'];
            debugPrint(cover);
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  void selectFromGalleryOthers(String kind, int index) async {
    _selectedImage = await ImagePicker().pickImage(source: kind == 'gallery' ? ImageSource.gallery : ImageSource.camera, imageQuality: 25);
    update();
    if (_selectedImage != null) {
      Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(width: 30),
                const CircularProgressIndicator(color: ThemeProvider.appColor),
                const SizedBox(width: 30),
                SizedBox(child: Text("Please wait".tr, style: const TextStyle(fontFamily: 'bold'))),
              ],
            )
          ],
        ),
        barrierDismissible: false,
      );
      Response response = await parser.uploadImage(_selectedImage as XFile);
      Get.back();
      if (response.statusCode == 200) {
        _selectedImage = null;
        if (response.body['data'] != null && response.body['data'] != '') {
          dynamic body = response.body["data"];
          if (body['image_name'] != null && body['image_name'] != '') {
            gallery[index] = body['image_name'];
            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    }
  }

  void onServiceCategories() {
    Get.delete<ServicesCategoriesController>(force: true);
    Get.toNamed(AppRouter.getServicesCategoriesRoute());
    update();
  }
}
