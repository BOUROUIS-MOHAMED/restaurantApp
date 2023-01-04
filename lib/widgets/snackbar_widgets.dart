import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


class SnackBarWidgets{

static  void successSnackBar(String title,String message){
    Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        borderRadius: 10,
        backgroundColor:  Colors.green[200] ,
        icon: Icon(
        FontAwesomeIcons.check
    ));
  }
static  void warningSnackBar(String title,String message){
  Get.snackbar(
      "Warning: ${title}",
      message,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      borderRadius: 10,
      backgroundColor:  Colors.yellowAccent[200] ,
      icon: Icon(
          FontAwesomeIcons.info
      ));
}
static  void alertSnackBar(String title,String message){
  Get.snackbar(
      "Error: ${title}",
      "Error Code:${message}",
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      borderRadius: 10,
      backgroundColor:  Colors.red[200] ,
      icon: Icon(
          FontAwesomeIcons.triangleExclamation
      ));
}

}