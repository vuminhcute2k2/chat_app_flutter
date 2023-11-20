import 'package:chatapp_project/consts/colors.dart';
import 'package:chatapp_project/controller/chats_controller.dart';
import 'package:chatapp_project/services/store_services.dart';
import 'package:chatapp_project/views/chat_screen/components/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class ChatScreen extends StatelessWidget {
  
  const ChatScreen({
    Key? key,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller =  Get.put(ChatController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          const Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                      child: RichText(
                          text: TextSpan(
                    children: [
                      TextSpan(
                        //user the username from the chatscreen
                        text: "${controller.friendname}\n",
                        style:const TextStyle(
                            fontFamily: bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      TextSpan(
                        text: "last seen",
                        style: TextStyle(
                          fontFamily: bold,
                          fontSize: 12,
                          color: Vx.gray600,
                        ),
                      ),
                    ],
                  ))),
                  const CircleAvatar(
                    backgroundColor: btnColor,
                    child: Icon(
                      Icons.video_call_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                    backgroundColor: btnColor,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            //this is our chat body 
            Obx(
              ()=>Expanded(
                //if isloading value is true? show progress indicator else show our chat
                child:controller.isloading.value ? 
                const Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(bgColor),
                ),) :
                 StreamBuilder(
                  stream: StoreServices.getChats(controller.chatId),
                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData){
                      //if no data is received yet
                      return Container();
                    }else{
                      return ListView(
                      children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                        var doc =  snapshot.data!.docs[index];
                        return chatBubble(index,doc);
                      }).toList(),
                    );
                    }        
                  },
                ),
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 54,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextFormField(
                        controller: controller.messageController,
                        maxLines: 1,
                        style:const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        cursorColor: Colors.white,
                        decoration:const InputDecoration(
                          prefixIcon: Icon(Icons.emoji_emotions_rounded,color: greyColor,),
                          suffixIcon: Icon(Icons.attach_file,color: greyColor,),
                          border: InputBorder.none,
                          hintText: "Type message here...",
                          hintStyle: TextStyle(
                            fontFamily: bold,
                            fontSize: 14,
                            color: greyColor,
                          ),
                        ),
                      ),
                  )),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {
                      controller.sendmessage(controller.messageController.text);
                    },
                    child: const CircleAvatar(
                      backgroundColor: btnColor,
                      child: Icon(Icons.send,color: Colors.white,),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
