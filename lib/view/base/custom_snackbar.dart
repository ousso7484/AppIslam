import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zabi/util/dimensions.dart';

void showCustomSnackBar(String message, {bool isError = true}) {
  Get.showSnackbar(GetSnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    message: message,
      duration: const Duration(seconds: 3),
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    snackPosition: SnackPosition.TOP,
  ));
}


// void customSnackBar(String message1,String message2, {bool isError = true}) {
//   Get.snackbar(
//
//     message1,
//     message2,
//     backgroundColor: isError ? Colors.red : Colors.green,
//     duration: const Duration(seconds: 3),
//     snackStyle: SnackStyle.FLOATING,
//     margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//     borderRadius: 10,
//     isDismissible: true,
//     dismissDirection: DismissDirection.horizontal,
//     snackPosition: SnackPosition.TOP,
//   );
// }
