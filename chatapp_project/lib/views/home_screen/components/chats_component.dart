import 'package:chatapp_project/consts/colors.dart';
import 'package:chatapp_project/services/store_services.dart';
// import 'package:chatapp_project/views/chat_screen/chat_screen.dart';
import 'package:chatapp_project/views/home_screen/components/messages_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ChatsComponent() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: StreamBuilder(
      stream: StoreServices.getMessages(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                bgColor
              ),
            ),
          );
        }
        else if(snapshot.data!.docs.isEmpty){
          return Center(
            child: "Start a conversation...".text.semiBold.color(txtColor).make(),
          );
        }else{
          return ListView(
            children: snapshot.data!.docs.mapIndexed((currentValue, index){
              var doc = snapshot.data!.docs[index];
              return messageBubble(doc);
            }).toList(),
          );
        }
      },
    ),
  );
}
