// import 'package:chatapp_project/consts/colors.dart';
import 'package:chatapp_project/consts/consts.dart';
import 'package:chatapp_project/controller/profile_controller.dart';
import 'package:chatapp_project/services/store_services.dart';
import 'package:chatapp_project/views/profile_screen/components/picker_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'dart:io';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //init profile controller
    var controller = Get.put(ProflieController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: profile.text.semiBold.make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          //save button to update profile
          TextButton(
              onPressed: () async{
                //put upload img method here 
                if(controller.imgpath.isEmpty){
                  //if img is selected then only update the values
                  controller.updateProfile(context);
                }else{
                  //update both profile img and value
                  //let wait for our img to be upload first 
                  await controller.uploadImage();
                  controller.updateProfile(context);
                }
              },
              child: "Save".text.white.semiBold.make()),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        //init futureBuilder
        child: FutureBuilder(
            //padding current user id  to the function to get the user document in firestore
            future: StoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //if data in loaded show the widget
              if (snapshot.hasData) {
                //setting snapshot into a variable for each access
                //here docs[0] because it will contain only one document
                var data = snapshot.data!.docs[0];

                //setting values to the text controller
                controller.nameController.text = data['name'];
                controller.phoneController.text = data['phone'];
                controller.aboutController.text = data['about'];

                return Column(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 80,
                        backgroundColor: btnColor,
                        child: Stack(
                          children: [
                            //when imgpath is empty
                            controller.imgpath.isEmpty && data['image_url'] ==''
                                ? Image.asset(
                                    "assets/icons/ic_user.png",
                                    color: Colors.white,
                                  )
                                //when imgpath is not empty means file is selected
                                : controller.imgpath.isNotEmpty ? Image.file(File(controller.imgpath.value))
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make():
                                    //show network img form document
                                    Image.network(data['image_url'],).box.roundedFull.clip(Clip.antiAlias).make(),
                            Positioned(
                              right: 0,
                              bottom: 20,
                              //show dialog on tap of this button
                              child: CircleAvatar(
                                backgroundColor: btnColor,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  //using velocityX onTap here
                                ).onTap(() {
                                  //using getx dialog and passing our widget
                                  //passing context and our controller to the widget
                                  Get.dialog(pickerDialog(context, controller));
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: TextFormField(
                        //setting controller
                        controller: controller.nameController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            label: "Name".text.white.make(),
                            isDense: true,
                            labelStyle: const TextStyle(
                              fontFamily: bold,
                              color: Colors.white,
                            )),
                      ),
                      subtitle: namesub.text.semiBold.gray400.make(),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      title: TextFormField(
                        controller: controller.aboutController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            label: "About".text.white.make(),
                            isDense: true,
                            labelStyle: const TextStyle(
                              fontFamily: bold,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      title: TextFormField(
                        controller: controller.phoneController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        readOnly: true,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            label: "Phone".text.white.make(),
                            isDense: true,
                            labelStyle: const TextStyle(
                              fontFamily: bold,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                );
              } else {
                //if data is not loaded yet show progress indication
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }
            }),
      ),
    );
  }
}
