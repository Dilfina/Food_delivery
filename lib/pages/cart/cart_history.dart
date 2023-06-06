import 'dart:convert';

import 'package:e_commerce/app_constants.dart';
import 'package:e_commerce/colors.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/dimensions.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/widgets/app_icon.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';
import '../../models/cart_model.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistory = Get.find<CartController>().getCartHistory().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for(int i=0; i<getCartHistory.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistory[i].time)){
        cartItemsPerOrder.update(getCartHistory[i].time!, (value)=>++value);

      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistory[i].time!, ()=>1);
      }
    }
    List<int> cartItemsPerOrderList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }
    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }
    List<int> itemsPerOrder = cartItemsPerOrderList();
    var listCounter=0;

    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index<getCartHistory.length) {
        DateTime parseData = DateFormat("yyyy-MM-dd HH:mm:ss").parse(
            getCartHistory[listCounter].time!);
        var inputDate = DateTime.parse(parseData.toString());
        var outputFormat = DateFormat("MM/dd/yyyy kk:mm a");
        outputDate = outputFormat.format(inputDate);
      }
        return BigText(text: outputDate);

    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height10*10,
            color: AppColor.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined, iconColor: AppColor.mainColor,)
              ],

            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistory().length>0?
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.height20,
                    right: Dimensions.height20
                ),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    children: [
                      for(int i=0; i<itemsPerOrder.length; i++)

                        Container(
                          height: Dimensions.height10*12,

                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              timeWidget(listCounter),
                              // ((){
                              //   DateTime parseData=  DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistory[listCounter].time!);
                              //   var inputDate = DateTime.parse(parseData.toString());
                              //   var outputFormat = DateFormat("MM/dd/yyyy kk:mm a");
                              //   var outputDate = outputFormat.format(inputDate);
                              //   return BigText(text: outputDate);
                              // }()),

                              SizedBox(height: Dimensions.height10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i], (index) {
                                      if(listCounter<getCartHistory.length){
                                        listCounter++;
                                      }
                                      return index<=2?
                                      Container(
                                        height: Dimensions.height20*4,
                                        width: Dimensions.height20*4,
                                        margin: EdgeInsets.only(right: Dimensions.height10/2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius30/4),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistory[listCounter-1].img!
                                              ),
                                            )
                                        ),
                                        // child: Text("Hi there"),

                                      ): Container();

                                    }),
                                  ),
                                  Container(
                                    height: Dimensions.height20*4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SmallText(text: "Total", color: AppColor.titleColor,),
                                        BigText(text: itemsPerOrder[i].toString()+ " Items", color: AppColor.titleColor,),
                                        GestureDetector(
                                          onTap: (){
                                            //print("hey, you clicked");

                                            var orderTime = cartOrderTimeToList();
                                            // print("Order time "+ orderTime[i].toString());
                                            Map<int, CartModel> moreOrder = {};
                                            for(int j=0; j<getCartHistory.length; j++){
                                              if(getCartHistory[j].time==orderTime[i]){
                                                print("My order time is "+ orderTime[i]);
                                                moreOrder.putIfAbsent(getCartHistory[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(getCartHistory[j])))
                                                );
                                              }
                                            }
                                            Get.find<CartController>().setItems = moreOrder;
                                            Get.find<CartController>().addToCartList();
                                            Get.toNamed(RouteHelper.getCartPage());

                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.height10, vertical: Dimensions.height10/2),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                                border: Border.all(width: 1, color: AppColor.mainColor)
                                            ),
                                            child: SmallText(text: "one more", color: AppColor.mainColor,),
                                          ),
                                        )
                                      ],
                                    ),

                                  ),
                                ],
                              )
                            ],
                          ),


                        )
                    ],
                  ),
                ),
              ),
            ):
            SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
                child: const Center(child:  NoDataPage(text:"You did not buy anything so far", img: "assets/images/box.png", )));

          }),

        ],
      ),
    );
  }
}
