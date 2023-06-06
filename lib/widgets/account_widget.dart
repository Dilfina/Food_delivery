import 'package:e_commerce/dimensions.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;

  AccountWidget({Key? key,
  required this.appIcon,
  required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow:[
         BoxShadow(
           blurRadius: 1,
           offset: Offset(0, 2),
           color: Colors.grey.withOpacity(0.2)
         ),
        ],
      ),

      padding: EdgeInsets.only(left: Dimensions.height20,
      top: Dimensions.height10,
      bottom: Dimensions.height10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.height20,),
          bigText
        ],
      ),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   boxShadow: [
      //     BoxShadow(
      //       blurRadius: 1,
      //       //offset: Offset(0,2),
      //       //color: Colors.grey.withOpacity(0.2),
      //     ),
      //   ],
      // ),
    );
  }
}
