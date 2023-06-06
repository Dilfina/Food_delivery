import 'package:e_commerce/dimensions.dart';
import 'package:e_commerce/pages/auth/sign_up_page.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snackbar.dart';
import '../../colors.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();


    void _login(AuthController authController){
      //var authController = Get.find<AuthController>();

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnackBar("Type in your email address", title: "Email address");

      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Valid email address");

      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "password");

      }else if(password.length<6){
        showCustomSnackBar("Password cannot be less than six characters", title: "Password");

      }else{
        showCustomSnackBar("All went well", title: "Perfect");


        authController.login(email, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
            print("Success registration");
          }else{
            showCustomSnackBar(status.message);
          }
        });
       // print(signUpBody.toString());

      }
    }


    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      "assets/images/logo.png",
                    ),
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.height20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold

                      ),),
                    Text("Sign into your account",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        color: Colors.grey[500],
                        //fontWeight: FontWeight.bold
                      ),),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                textController: emailController,
                hintText: "Email",
                icon: Icons.email,
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(
                textController: passwordController,
                hintText: "Password",
                icon: Icons.password_sharp,
                isObscure: true,
              ),
              SizedBox(height: Dimensions.height20,),

              //tag line
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(text: TextSpan(
                      text: "Sign into your account",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      )
                  )),
                  SizedBox(width: Dimensions.height20,)
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sing in button
              GestureDetector(
                onTap: (){
                  _login(authController);

                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColor.mainColor
                  ),
                  child: Center(child: BigText(text: "Sign in", size: Dimensions.font20+Dimensions.font20/2, color: Colors.white,)),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up options
              RichText(
                text: TextSpan(
                    text: "Don\'t have an account?",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.fade),
                        text: " Create",
                        style: TextStyle(
                            color: AppColor.mainBlackColor,
                            fontSize: Dimensions.font16,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                    ]
                ),
              ),
            ],
          ),
        ): CustomLoader();
      }),
    );
  }
}
