import 'package:e_commerce/colors.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/controllers/location_controller.dart';
import 'package:e_commerce/controllers/user_controller.dart';
import 'package:e_commerce/dimensions.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
    45.51563, -122.677433
  ), zoom: 17);

  late LatLng _initialPosition=const LatLng(
      45.51563, -122.677433
  );

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    _isLogged = Get.find<AuthController>().userHasLoggedIn();
    if(_isLogged&&Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      _cameraPosition=CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"])
      ));

      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address page"),
        backgroundColor: AppColor.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (locationController){
        _addressController.text = '${locationController??''}'
        '${locationController.placemark.locality??''}'
        '${locationController.placemark.postalCode??''}'
        '${locationController.placemark.country??''}';
        print("address in my view is "+_addressController.text);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 5, right: 5, top:5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 2,
                    color:Theme.of(context).primaryColor,
                  )
              ),
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 17,),
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: false,
                      onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition, true);

                      },
                      onCameraMove: ((position)=>_cameraPosition=position),
                      onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);



                      }
                  ),

                ],
              ),
            ),
            SizedBox(height: Dimensions.height20,),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.height20),
              child: BigText(text: "Delivery Address"),
            ),
            SizedBox(height: Dimensions.height20,),
            AppTextField(textController: _addressController, hintText: "Your address", icon: Icons.map),


          ],
        );
      })
    );
  }
}
