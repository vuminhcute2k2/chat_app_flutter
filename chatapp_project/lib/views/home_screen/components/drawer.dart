import 'package:chatapp_project/consts/consts.dart';
import 'package:chatapp_project/controller/home_controller.dart';
import 'package:chatapp_project/main.dart';
// import 'package:chatapp_project/views/chat_screen/chat_screen.dart';
import 'package:chatapp_project/views/profile_screen/profile.dart';
import 'package:get/get.dart';

// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';
Widget drawer() {
  return Drawer(
    backgroundColor: bgColor,
    shape: const RoundedRectangleBorder(
      borderRadius:
          BorderRadiusDirectional.horizontal(start: Radius.circular(25)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              backIcon,
              color: Colors.white,
            ).onTap(() {
              Get.back();
            }),
            title: settings.text.semiBold.white.make(),
          ),
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 45,
            backgroundColor: btnColor,
            // child: Image.asset(
            //   "assets/icons/ic_user.png",
            // ),
            child: Image.network(
              HomeController.instance.userImage,fit: BoxFit.cover,
            ).box.roundedFull.clip(Clip.antiAlias).make(),
          ),
          const SizedBox(
            height: 10,
          ),
          HomeController.instance.username.text.semiBold.white.size(16).make(),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: btnColor,
            height: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          ListView(
            shrinkWrap: true,
            children: List.generate(
              drawerIconsList.length,
              (index) => ListTile(
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.to(()=>const ProfileScreen(),transition: Transition.downToUp);
                      break;
                    default:
                  }
                },
                leading: Icon(
                  drawerIconsList[index],
                  color: Colors.white,
                ),
                title: drawerListTitles[index].text.semiBold.white.make(),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          const Divider(
            color: btnColor,
            height: 1,
          ),
          const SizedBox(height: 10,),
          ListTile(
            leading:const Icon(inviteIcon,color: Colors.white,),
            title: invite.text.semiBold.white.make(),
          ),
          Spacer(),
          ListTile(
            onTap: () async{
             await auth.signOut();
             Get.offAll(()=>const ChatApp());
            },
            leading:const Icon(logoutIcon,color: Colors.white,),
            title: logout.text.semiBold.white.make(),
          )
        ],
      ),
    ),
  );
}
