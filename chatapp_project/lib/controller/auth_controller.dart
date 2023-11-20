// import 'dart:ffi';
// import 'package:http/http.dart' as http;

import 'package:chatapp_project/consts/firebase_consts.dart';
import 'package:chatapp_project/consts/strings.dart';
import 'package:chatapp_project/views/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController{
  //text controller
  var usernameController=TextEditingController();
  var phoneController=TextEditingController();
  var otpController=List.generate(6, (index) => TextEditingController());
  //variables
  var isOtpsent = false.obs;
  var formKey = GlobalKey<FormState>();

  //auth variables
  late   PhoneVerificationCompleted phoneVerificationCompleted;
  late   PhoneVerificationFailed phoneVerificationFailed;
  late PhoneCodeSent phoneCodeSent;
  String verificationID= '';

  //send OTP method
  sendOtp()async{
    phoneVerificationCompleted = (PhoneAuthCredential credential) async{await auth.signInWithCredential(credential);};
    phoneVerificationFailed = (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
    };
    phoneCodeSent = (String verificationId, int? resendToken) {
      verificationID =verificationId;
    };
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+1${phoneController.text}",
      verificationCompleted:phoneVerificationCompleted ,
      verificationFailed:phoneVerificationFailed ,
      codeSent:phoneCodeSent ,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    } catch (e) {
      print(e.toString());
    }
  }

  //verify otp
  verifyOtp(context)async{
    String otp='';
    //getting all Textfield data
    for(var i=0;i<otpController.length;i++){
      otp +=otpController[i].text;
    }
    try {
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otp);
        //getting user
        final User? user = (await auth.signInWithCredential(phoneAuthCredential)).user;
        if(user!=null){
          //store user into database
          DocumentReference store = FirebaseFirestore.instance.collection(collectionUser).doc(user.uid);
          await store.set({
            'id': user.uid,
            'name': usernameController.text.toString(),
            'phone': phoneController.text.toString(),
            //lets add 2 empty field for latter use
            'about':'',
            'image_url':'',

          },SetOptions(merge: true));
          //showing toast of login
          VxToast.show(context, msg: loggedin);
          Get.offAll(()=>const HomeScreen(),transition: Transition.downToUp);
        }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
  
}