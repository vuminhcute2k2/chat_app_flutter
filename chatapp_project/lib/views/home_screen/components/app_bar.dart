import 'package:chatapp_project/consts/colors.dart';
import 'package:chatapp_project/consts/images.dart';
import 'package:chatapp_project/consts/strings.dart';
import 'package:chatapp_project/consts/utils.dart';
import 'package:chatapp_project/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
 Widget appBar(GlobalKey<ScaffoldState> key){
  return Container(
    padding:const EdgeInsets.only(right: 12),
    height: 80,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: Container(
            decoration:const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(100),bottomRight: Radius.circular(100))
            ),
            height: 80,
            width: 90,
            child:const Icon(settingsIcon,color: Colors.white,),
          ),
        ),
        RichText(text:const TextSpan(
          children: [
            TextSpan(
              text: "$appname\n",
              style: TextStyle(
                fontFamily: bold,
                fontSize: 22,
                color: bgColor,
              )
            ),
            TextSpan(
              text: "  $connnectingLives",
              style: TextStyle(
                fontFamily: "lato",
                fontSize: 14,
                color: Vx.gray600,
                fontWeight: FontWeight.w600,
              )
            ),
          ]
        )),
        CircleAvatar(
          backgroundColor: btnColor,
          radius: 25,
          child: Image.network(
            HomeController.instance.userImage, 
          ).box.roundedFull.clip(Clip.antiAlias).make(),

        ),
      ],
    ),
  );
 }