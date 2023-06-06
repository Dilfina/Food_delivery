import 'package:e_commerce/base/custom_loader.dart';
import 'package:e_commerce/colors.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/dimensions.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../widgets/account_widget.dart';
import '../../widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userHasLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(child: BigText(text: "Profile", size:24,color: Colors.white,)),
        backgroundColor: AppColor.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn? (userController.isLoading? Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(


            children: [
              AppIcon(icon: Icons.person,
                backgroundColor: AppColor.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45+Dimensions.height30,
                size: Dimensions.height15*10,),
              SizedBox(height: Dimensions.height30,),
              Expanded(
                child: SingleChildScrollView(

                  child: Column(
                    children: [
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColor.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5, ),
                        bigText: BigText(text: userController.userModel.name),),
                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.phone,
                          backgroundColor: AppColor.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5, ),
                        bigText: BigText(text: "87718110511"),),
                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.email,
                          backgroundColor: AppColor.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5, ),
                        bigText: BigText(text: "info@gmail.com"),),
                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.location_on,
                          backgroundColor: AppColor.yellowColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5, ),
                        bigText: BigText(text: "Fill in your address"),),
                      SizedBox(height: Dimensions.height20,),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.message_outlined,
                          backgroundColor: Colors.redAccent,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height10*5/2,
                          size: Dimensions.height10*5, ),
                        bigText: BigText(text: "Messages"),),
                      SizedBox(height: Dimensions.height20,),
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userHasLoggedIn()) {
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.offNamed(RouteHelper.getSignInPage());
                          }else{
                            print("you logged out");
                          }
                        },
                        child: AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.logout_outlined,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5, ),
                          bigText: BigText(text: "Logout"),),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    ],
                  ),
                ),
              )



            ],
          ),
        ):
        CustomLoader()):
        Container(child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
          width: double.maxFinite,
          height: Dimensions.height20*10,
          margin: EdgeInsets.only(left: Dimensions.height20,
          right: Dimensions.height20),
          decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/bi.png"
                  )
                )
          ),
        ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignInPage());
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20*5,
                    margin: EdgeInsets.only(left: Dimensions.height20,
                        right: Dimensions.height20),
                    decoration:  BoxDecoration(
                      color: AppColor.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.height20)
                    ),
                    child: Center(child: BigText(text: "Sign In", color: Colors.white,size: Dimensions.font26,)),
                  ),
                ),

              ],
            )),);
      }),

    );
  }
}
