import 'package:e_commerce/colors.dart';
import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/data/repository/popular_product_repo.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList=> _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity=0;
  int get quantity=> _quantity;

  int _inCartItem=0;
  int get inCartItem=>_inCartItem+_quantity;


  Future<void> getPopularProductList() async{
    Response response=await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){
      print('data got');
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
     // print(_popularProductList);
      _isLoaded=true;
      update();
    }else{

    }

  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity=checkQuantity(_quantity+1);

    }else{
      _quantity=checkQuantity(_quantity-1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItem + quantity<0)){
      Get.snackbar("Item count", "You can't reduce more",
          colorText: Colors.white, backgroundColor: AppColor.mainColor);
      if(_inCartItem>0){
        _quantity=- _inCartItem;
        return _quantity;
      }
      return 0;
    }else if((_inCartItem + quantity>20)){
      Get.snackbar("Item count", "You can't add more",
          colorText: Colors.white, backgroundColor: AppColor.mainColor);
      return 20;
    }else{
      return quantity;
    }

  }

  void initProduct(ProductModel product, CartController cart){
    _quantity=0;
    _inCartItem=0;
    _cart=cart;
    var exist = false;
    exist = _cart.existInCart(product);

    print("exist or not " + exist.toString());
    if(exist){
      _inCartItem=_cart.getQuantity(product);

    }
    //print("the quantity in the cart is "+_inCartItem.toString());


  }

  void addItem(ProductModel product){
    // if(_quantity>0){

      _cart.addItem(product, _quantity);
      _quantity=0;
      _inCartItem=_cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print("The id is " + value.id.toString());

      });

    // }else{
    //   Get.snackbar("Item count", "You at least add an item!",
    //       colorText: Colors.white, backgroundColor: AppColor.mainColor);
    //
    // }
    update();

  }

  int get totalItems{
    return _cart.totalItems;
  }
  List<CartModel> get getItems{
    return _cart.getItems;
  }

}