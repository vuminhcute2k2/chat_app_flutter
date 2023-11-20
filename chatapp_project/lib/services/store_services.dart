import 'package:chatapp_project/consts/firebase_consts.dart';

class StoreServices{
  //get user data
 static getUser(String id){
    return firebaseFirestore.collection(collectionUser).where('id',isEqualTo: id).get();
  }
  //get all users from our firebase users collection
  static getAllUsers(){
    return firebaseFirestore.collection(collectionUser).snapshots();
  }
  //get all chat 
  static getChats(String chatId){
    return firebaseFirestore.collection(collectionChats).doc(chatId).collection(collectionMessages).orderBy('created_on',descending: true).snapshots();
  }
  //get all messages
  static getMessages(){
    //get all messages from chat collection where user list include current user
    return firebaseFirestore.collection(collectionChats).where("user.${currentUser!.uid}",isNotEqualTo: null).where("created_on",isNotEqualTo: null).snapshots();
  }
}