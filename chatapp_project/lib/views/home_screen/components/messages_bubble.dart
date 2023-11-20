

import 'package:chatapp_project/consts/consts.dart';
import 'package:chatapp_project/views/chat_screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
Widget messageBubble(DocumentSnapshot doc){
  var t = doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Card(
          child: ListTile(
            onTap: () {
              Get.to(()=>const ChatScreen(),transition: Transition.downToUp,
              //lets pass the argument
              arguments: [
                currentUser!.uid == doc['toId'] ? doc['friend_name'] : doc['user_name'],
                currentUser!.uid == doc['toId'] ? doc['fromId'] : doc['toId'],
              ],
              );
            },
            leading: CircleAvatar(
                radius: 25,
                backgroundColor: bgColor,
                child: Image.asset(
                  "assets/icons/ic_user.png",
                )),
            title: 
            currentUser!.uid == doc['toId'] ? "${doc['friend_name']}".text.semiBold.size(14).make():"${doc['user_name']}".text.semiBold.size(16).make(),
            subtitle: "${doc['last_msg']}".text.maxLines(1).make(),
            trailing: Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.access_time_filled_rounded,size: 16,color: Vx.gray400,),
                label:time.text.gray400.size(12).make(),
              ),
            ),
          ),
        );
}