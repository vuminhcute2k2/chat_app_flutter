import 'package:chatapp_project/consts/consts.dart';
import 'package:chatapp_project/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{
  dynamic chatId;
  var chats = firebaseFirestore.collection(collectionChats);
  var userId = currentUser!.uid;
  var friendId =Get.arguments[1];
  var username = HomeController.instance.prefs.getStringList('user_details')![0];
  var friendname=Get.arguments[0];
  var messageController =TextEditingController();
  var isloading =false.obs;
  //creating chatroom
  getChatId()async{
    //it will see if there is a chatroom already created between 2 user
    isloading(true);
    await chats.where('users',isEqualTo: {friendId:null,userId:null}).limit(1).get().then((QuerySnapshot snapshot)async{
      if(snapshot.docs.isNotEmpty){
        chatId = snapshot.docs.single.id;
      }else{
        chats.add({
          'users':{userId:null,friendId:null},
          'friend_name': friendname,
          'user_name': username,
          'toId':'',
          'fromId':'',
          "created_on":null,
          'last_msg':''
        }).then((value) {
          //asign the doc id to our chatid var 
          {
            chatId =value.id;
          }
        });
      }
    });
    //when id is obtained make isloading false again
    isloading(false);
  }


  //send message method
  sendmessage(String msg){
    if(msg.trim().isNotEmptyAndNotNull){
      chats.doc(chatId).update({
        'created_on':FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId':userId,
      });
    }
    //now save the msg in database
    chats.doc(chatId).collection(collectionMessages).doc().set({
      'created_on': FieldValue.serverTimestamp(),
      'msg': msg,
      //uid this user to identify who send msg
      'uid': userId
    }).then((value){
      //after msf is send and saves clear the textfield
      messageController.clear();
    });
  }
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }
}