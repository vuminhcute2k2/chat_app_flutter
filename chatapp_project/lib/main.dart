// import 'package:chatapp_project/consts/colors.dart';
// import 'package:chatapp_project/consts/strings.dart';
// import 'package:chatapp_project/consts/utils.dart';
// import 'package:chatapp_project/views/chat_screen/chat_screen.dart';
import 'package:chatapp_project/views/home_screen/home.dart';
import 'package:chatapp_project/views/singin_screen/singin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
// import 'package:velocity_x/velocity_x.dart';
import 'package:chatapp_project/consts/consts.dart';
void main()async {
  //runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  runApp(const App());
}

// class App extends StatelessWidget {
//   const App({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       theme: ThemeData(
//           // fontFamily:
//           ),
//       debugShowCheckedModeBanner: false,
//       home: const ChatApp(),
//       title: appname,
//     );
//   }
// }
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  var isUser =false;
  checkUser()async{
     auth.authStateChanges().listen((User? user) {
        if(user == null && mounted){
          setState(() {
            isUser=false;
          });
        }
        else{
          setState(() {
            isUser=true;
          });
        }
        print("user value is $isUser");
      });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          // fontFamily:
          ),
      debugShowCheckedModeBanner: false,
      home: isUser?const HomeScreen():const ChatApp(),
      title: appname,
    );

  }
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                //color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        "assets/icons/logo.png",
                        width: 180,
                      ),
                    ),
                    appname.text.size(28).fontFamily(bold).make()
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10.0,
                     // runSpacing: 20.0,
                      children: List.generate(listOfFeatures.length, (index) {
                        return Chip(
                          labelPadding:const EdgeInsets.symmetric(vertical: 4,horizontal:18 ),
                          backgroundColor: Colors.transparent,
                          side:const BorderSide(
                            color: Vx.gray400
                          ),
                          label: listOfFeatures[index].text.semiBold.gray600.make()
                          );
                      }),
                    ),
                    const SizedBox(height: 20,),
                    slogan.text.size(38).fontFamily(bold).letterSpacing(2).make(),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(
                      width: context.screenWidth - 80,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          //primary: bgColor,
                          backgroundColor: bgColor,
                          shape: const StadiumBorder(),
                          padding:const EdgeInsets.all(16)
                        ),
                        onPressed: (){
                          Get.to(() =>const SigninScreen(),transition: Transition.downToUp);
                        },
                        child: cont.text.semiBold.size(16).make(),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    poweredby.text.size(15).gray600.make(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
