import 'package:e_commerce/app_constants.dart';
import 'package:e_commerce/colors.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommended_product_controller.dart';
import 'package:e_commerce/dimensions.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/expandable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets/big_text.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId, required  this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product  = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());


    print("page id is "+ pageId.toString());
    print("product name is "+ product.description.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers:<Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              GestureDetector(
                  child :  AppIcon(icon: Icons.clear),
              onTap: (){
                if(page=="cartpage"){
                  Get.toNamed(RouteHelper.getCartPage());
                }else{
                  Get.toNamed(RouteHelper.getInitial());
                }
              },),
             // AppIcon(icon: Icons.shopping_cart_outlined)
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=1)
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children : [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(

                            child: AppIcon(icon: Icons.circle, size: 20,iconColor: Colors.transparent, backgroundColor: AppColor.mainColor,),
                            right: 0,
                            top:0
                        )
                            :Container(),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(

                            child: BigText(text:Get.find<PopularProductController>().totalItems.toString(),
                              size: 12,
                              color: Colors.white,),
                            right: 3,
                            top:3
                        )
                            :Container()

                      ],
                    ),
                  );

                })

            ],

            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(

                child: Center(child: BigText(size: Dimensions.font26, text : product.name!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  )
                ),
              ),

            ),
            pinned: true,
            backgroundColor: AppColor.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(

            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text: product.description!),
                    margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20)

                ),
              ],

            ),
            ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return Column(
          //CONTINUE FROM HERE 4:51
          //mainAxisAlignment: MainAxisAlignment.,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left:Dimensions.height20*2.5,
                  right: Dimensions.height20*2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(false);
                      },
                      child: AppIcon(iconSize: Dimensions.iconSize24,iconColor: Colors.white,backgroundColor: AppColor.mainColor,icon: Icons.remove)),

                  BigText(text: "\$ ${product.price!}  X  ${controller.inCartItem} ", color: AppColor.mainBlackColor, size: Dimensions.font26,),
                  GestureDetector(
                      onTap: (){
                        controller.setQuantity(true);



                      },
                      child: AppIcon(iconSize: Dimensions.iconSize24,iconColor: Colors.white,backgroundColor: AppColor.mainColor,icon: Icons.add)),
                ],
              ),
            ),
            Container(
              height: Dimensions.pageViewTextContainer,
              padding: EdgeInsets.only(top:Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.height20, right: Dimensions.height20),
              decoration: BoxDecoration(
                color: AppColor.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.height20*2),
                    topRight: Radius.circular(Dimensions.height20*2)
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.height20, right: Dimensions.height20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.height20),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: AppColor.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.height20, right: Dimensions.height20),
                      child: BigText(text: "\$ ${product.price!} | Add to cart", color: Colors.white),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.height20),
                          color: AppColor.mainColor
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        );

      }),

    );
  }
}
