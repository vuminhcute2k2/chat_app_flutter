import 'package:chatapp_project/consts/consts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
Widget pickerDialog(context,controller){
  //setting listicons and titles
  var listTile = [camera,gallery,cancel];
  var icons = [Icons.camera_alt_rounded,Icons.photo_size_select_large_rounded,Icons.cancel_rounded];
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16)
    ),
    child: Container(
      padding:const EdgeInsets.all(12),
      color: bgColor,
      child: Column(
        //setting size to min
        mainAxisSize: MainAxisSize.min,
        children: [
          soucre.text.semiBold.white.make(),
          Divider(),
          const SizedBox(height: 10,),
          ListView(
            shrinkWrap: true,
            children: List.generate(3, (index) => ListTile(
              onTap: () {
                //setting ontap according to index
                switch (index) {
                  //ontap of camera
                  case 0:
                    //providing camera source
                    Get.back();
                    controller.pickImage(context,ImageSource.camera);
                    break;
                  //ontap of gallery
                  case 1:
                    //providing gallery source
                    Get.back();
                    controller.pickImage(context,ImageSource.gallery);
                    break;
                  //ontap of cancel
                  case 2:
                    //close dialog
                    Get.back();
                    break;    
                }
              },
              //getting icons from our list
              leading: Icon(icons[index],color: Colors.white,),
              //getting titles from our list
              title: listTile[index].text.white.make(),
            )),
          ),
        ],
      ),
    ),
  );
}