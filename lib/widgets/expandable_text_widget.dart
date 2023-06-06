import 'package:e_commerce/colors.dart';
import 'package:e_commerce/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce/widgets/small_text.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText=true;
  double textHeight=Dimensions.screenHeight/7.7;

  @override
  void initState(){
    super.initState();
    if(widget.text.length> textHeight){
      firstHalf=widget.text.substring(0, textHeight.toInt());
      secondHalf=widget.text.substring(textHeight.toInt()+1, widget.text.length);

    }else{
      firstHalf=widget.text;
      secondHalf="";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty? SmallText(color: AppColor.paraColor,size: Dimensions.font16, text: firstHalf) : Column(
        children: [
          SmallText(height: 1.8, color: AppColor.paraColor, size: Dimensions.iconSize16, text: hiddenText? (firstHalf+"...") : (firstHalf+secondHalf+secondHalf)),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText=!hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: "Show more", color: AppColor.mainColor,),
                Icon(hiddenText? Icons.arrow_drop_down: Icons.arrow_drop_up, color: AppColor.mainColor,)
              ],
            ),
          ),

        ],
      ),

    );
  }
}
