import 'package:e_commerce/app_constants.dart';
import 'package:e_commerce/colors.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/location_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/dimensions.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: Dimensions.height20,
              right: Dimensions.height20,
              top: Dimensions.height20*3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  SizedBox(width: Dimensions.height20*5,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColor.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ],

              ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?
            Positioned(
                top: Dimensions.height20*5,
                left: Dimensions.height20,
                right: Dimensions.height20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  //color: Colors.red,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController){
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index){
                            return Container(
                              height: Dimensions.height20*5,
                              width: double.maxFinite,
                              //color: Colors.blue,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      width: Dimensions.height20*5,
                                      height: Dimensions.height20*5,
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL+ AppConstants.UPLOAD_URL+ cartController.getItems[index].img!
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: (){
                                      var popularIndex = Get.find<PopularProductController>().
                                      popularProductList.indexOf(_cartList[index].product!);
                                      if(popularIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartpage"));

                                      }else{
                                        var recommendedIndex = Get.find<RecommendedProductController>().
                                        recommendedProductList.indexOf(_cartList[index].product!);
                                        if(recommendedIndex<0) {
                                          Get.snackbar("History product", "Product review is not available for history product",
                                              colorText: Colors.white, backgroundColor: AppColor.mainColor);

                                        }else{
                                          Get.toNamed(
                                              RouteHelper.getRecommendedFood(
                                                  recommendedIndex, "cartpage"));
                                        }

                                      }
                                    },
                                  ),
                                  SizedBox(width: Dimensions.height10,),
                                  Expanded(
                                      child: Container(
                                        height: Dimensions.height20*5,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(text:cartController.getItems[index].name!, color: Colors.black54,),
                                            SmallText(text: "Spicy", ),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  BigText(text: "\$ "+cartController.getItems[index].price!.toString(), color: Colors.redAccent,),
                                                  Container(
                                                    padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.height10, right: Dimensions.height10),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimensions.height20),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      children: [

                                                        GestureDetector(
                                                          onTap: (){
                                                            cartController.addItem(_cartList[index].product!, -1);


                                                          },
                                                          child: Icon(Icons.remove, color: AppColor.signColor,),),
                                                        SizedBox(width: Dimensions.height10/2,),
                                                        BigText(text: _cartList[index].quantity.toString()),//popularProduct.inCartItem.toString()"),
                                                        SizedBox(width: Dimensions.height10/2,),
                                                        GestureDetector(
                                                            onTap: (){
                                                              cartController.addItem(_cartList[index].product!, 1);
                                                            },
                                                            child: Icon(Icons.add, color: AppColor.signColor,))
                                                      ],
                                                    ),
                                                  ),
                                                ]
                                            )

                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            );
                          });

                    }),
                  ),

                ) ): NoDataPage(text: "Your cart is empty!");
          })

        ],
      ),
    bottomNavigationBar: GetBuilder<CartController> (builder: (cartController){
        return Container(
        height: Dimensions.pageViewTextContainer,
        padding: EdgeInsets.only(top:Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.height20, right: Dimensions.height20),
        decoration: BoxDecoration(
        color: AppColor.buttonBackgroundColor,
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Dimensions.height20*2),
        topRight: Radius.circular(Dimensions.height20*2)
        ),
        ),
        child: cartController.getItems.length>0?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.height20, right: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.height20),
                color: Colors.white,
              ),
              child: Row(
                children: [

                  SizedBox(width: Dimensions.height10/2,),
                  BigText(text: "\$ "+ cartController.totalAmount.toString()),
                  SizedBox(width: Dimensions.height10/2,),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                // popularProduct.addItem(product);
                if(Get.find<AuthController>().userHasLoggedIn()){
                  if(Get.find<LocationController>().addressList.isEmpty){
                    Get.toNamed(RouteHelper.getAddressPage());

                  }
                  cartController.addToHistory();
                }else{
                  Get.toNamed(RouteHelper.getSignInPage());
                }
              },
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.height20, right: Dimensions.height20),
                child: BigText(text: "Check out", color: Colors.white),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.height20),
                    color: AppColor.mainColor
                ),
              ),
            ),
          ],
        ):
            Container()
        );
        },

        )
    );
  }
}
