import 'package:e_commerce/dimensions.dart';
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overFlow;

  BigText({Key? key, this.color= const Color(0xFF332d2b),
    required this.text,
  this.overFlow=TextOverflow.ellipsis,
  this.size=0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontSize: size==0 ? Dimensions.font20: size,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
