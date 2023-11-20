import 'package:chatapp_project/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;
Widget chatBubble (index,DocumentSnapshot doc){
  var t =doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
                    textDirection: doc['uid']==currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: doc['uid'] == currentUser!.uid ? bgColor : btnColor,
                            child: Image.asset(
                              "assets/icons/ic_user.png",
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:doc['uid'] == currentUser!.uid ?  bgColor : btnColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: "${doc['msg']}"
                                  .text
                                  .semiBold
                                  .white
                                  .make(),
                            ),
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: time
                                .text
                                .gray400
                                .fontFamily(light)
                                .size(12)
                                .make(),
                          ),
                        ],
                      ),
                    ),
                  );
}