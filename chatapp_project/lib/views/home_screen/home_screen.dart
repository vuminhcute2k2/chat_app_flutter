import 'package:chatapp_project/consts/colors.dart';
import 'package:chatapp_project/controller/home_controller.dart';
// import 'package:chatapp_project/views/home_screen/components/app_bar.dart';
// import 'package:chatapp_project/views/home_screen/components/drawer.dart';
// import 'package:chatapp_project/views/home_screen/components/tab_bar.dart';
// import 'package:chatapp_project/views/home_screen/components/tabbarviews.dart';
import 'package:chatapp_project/views/views.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey =GlobalKey<ScaffoldState>();
    var controller = Get.put(HomeController());
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: scaffoldKey,
          drawer: drawer(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: bgColor,
            onPressed: () {
              //goto compose screen
              Get.to(()=>ComposeScreen(),transition: Transition.downToUp);
            },
            child: const Icon(Icons.add),
          ),
          backgroundColor: bgColor,
          body: Column(
            children: [
              appBar(scaffoldKey),
              Expanded(
                child: Row(
                  children: [
                    tabbar(),
                    tabbarView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
