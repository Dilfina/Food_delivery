import 'package:e_commerce/pages/cart/cart_page.dart';
import 'package:e_commerce/pages/food/recommended_food_detail.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/address/add_address_page.dart';
import '../pages/auth/sign_in_page.dart';
import '../pages/food/popular_food_detail.dart';
import '../pages/home/home_page.dart';
import '../pages/splash/splash_page.dart';

class RouteHelper{
  static const String initial ="/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String splashPage = "/splash-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";

  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getInitial()=>'$initial';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';
  static String getSplashPage()=>'$splashPage';
  static String getSignInPage()=>'$signIn';
  static String getAddressPage()=>'$addAddress';



  static List<GetPage> routes = [
    GetPage(name: initial, page: ()=>HomePage()),
    GetPage(name: signIn, page: ()=>SignInPage(), transition: Transition.fade),

    GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page= Get.parameters['page'];
      return PopularFoodDetail(pageId: int.parse(pageId!), page:page!);
  },
      transition: Transition.fadeIn
  ),
    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetail(pageId: int.parse(pageId!), page:page!);
  },
      transition: Transition.fadeIn,
  ),
    GetPage(name: cartPage, page: (){
      return CartPage();
    },
      transition: Transition.fadeIn
    ),
    GetPage(name: splashPage, page: (){
      return SplashScreen();
    },),
    GetPage(name: addAddress, page: (){
      return AddAddressPage();
    },
        transition: Transition.fadeIn
    ),




  ];

}