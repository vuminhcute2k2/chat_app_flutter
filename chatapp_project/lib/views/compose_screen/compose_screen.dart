import 'package:chatapp_project/consts/consts.dart';
import 'package:chatapp_project/services/store_services.dart';
import 'package:chatapp_project/views/chat_screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: "New Message".text.semiBold.make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          //make top two cornenrs rounded
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          color: Colors.white,
        ),
        //we are using stream builder here for realtime changes
        child: StreamBuilder(
          stream: StoreServices.getAllUsers(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              //if data is not load yet
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(bgColor),
                ),
              );
            } else {
              //when data is loaded

              //we are using grid view here
              return GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                //here we are coverting our snapshot into a map for easy access to all the docs
                children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                  //setting our each doc into a var for easy access
                  var doc = snapshot.data!.docs[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: bgColor.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      //lets see if our data is coming or not
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    NetworkImage("${doc['image_url']}"),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              "${doc["name"]}"
                                  .text
                                  .semiBold
                                  .color(txtColor)
                                  .make(),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(12),
                                  //primary: bgColor,
                                ),
                                onPressed: () {
                                  //on tap of this button we are going to send our user to the chat screen
                                  Get.to(
                                      () => ChatScreen(),
                                      transition: Transition.downToUp,
                                      arguments: [
                                        doc['name'],
                                        doc['id'],
                                      ],
                                      );
                                },
                                icon: const Icon(Icons.message),
                                label: "Message".text.make()),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
