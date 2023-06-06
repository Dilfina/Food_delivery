import 'package:e_commerce/colors.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("I am printing loading state "+ Get.find<AuthController>().isLoading.toString());

    return Center(
      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.height20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20*5/2),
          color: AppColor.mainColor
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(color:  Colors.white,),
      ),
    );
  }
}
