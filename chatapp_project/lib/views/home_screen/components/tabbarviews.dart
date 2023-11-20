import 'package:chatapp_project/views/home_screen/components/chats_component.dart';
import 'package:chatapp_project/views/home_screen/components/status_component.dart';
import 'package:flutter/material.dart';
import '../../views.dart';
Widget tabbarView() {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12))),
      child: TabBarView(
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(12)),
                color: Colors.white),
            child: ChatsComponent(),
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(12)),
                color: Colors.white),
            child: statusComponent(),    
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(12)),
                color: Colors.yellow),
          ),
        ],
      ),
    ),
  );
}
