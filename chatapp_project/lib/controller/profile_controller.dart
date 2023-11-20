
import 'dart:io' as io;
import 'package:chatapp_project/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
class ProflieController extends GetxController{
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  var phoneController = TextEditingController();
  //variables for image
  var imgpath = ''.obs;
  var imglink='';
  //update profile method
  updateProfile(context)async{
    //setting store variable to the document of our current user
    var store = firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);
    //lets update data now
    await store.set(
      {
        'name':nameController.text,
        'about':aboutController.text,
        //update the image_url field
        //it will be empty if img is not selected 
        'image_url': imglink

      },SetOptions(merge: true));
      //show toats when done
      VxToast.show(context, msg: "Profile updates successfully!");
  }
  //image picking method
  pickImage(context,source)async{
    //get premistion from user
    await Permission.photos.request();
    await Permission.camera.request();
    //getting state of our permisson to handle
    var status = await Permission.photos.status;
    //handle status
    if(status.isGranted){
      //when status is grandted
      try {
        //source will be accacrding to user choice
        //picking image and saving in img variables
        final img = await ImagePicker().pickImage(source: source,imageQuality: 80);
        //setting our variables equal to this image path
        imgpath.value= img!.path;
        //show toast after picking image
        VxToast.show(context, msg: "Image selected");
      }on PlatformException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
    }else{
      //when status is not grandted
      VxToast.show(context, msg: "Premisstion denied");
    }

  }
  //lets upload the image to fire storage
  uploadImage()async{
    //getting  name of the selected file
    //
    var name =basename(imgpath.value);
    //setting destination of file on firestore
    var destination ='images/${currentUser!.uid}/$name';
    //trigering firestorage  to save of file
    //adding the desination to create of file
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    //uploading our file
    io.File file = io.File(imgpath.value);  // Sử dụng tên bí danh 'io' để truy cập lớp 'File'
    await ref.putFile(file);
    //getting url of our upload file and saving it into our  linking variable
    var d = await ref.getDownloadURL();
    print(d);
    imglink = d;  
  }


}