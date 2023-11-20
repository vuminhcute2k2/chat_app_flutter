import 'package:chatapp_project/consts/consts.dart';
Widget statusComponent(){
  return Container(
    padding:const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: btnColor,
            child: Image.asset("assets/icons/ic_user.png"),
          ),
          title: "My status".text.semiBold.color(txtColor).make(),
          subtitle: "Tap to add status updates".text.gray400.make(),
        ),
        const SizedBox(height: 20,),
        recentupdates.text.semiBold.color(txtColor).make(),
        const SizedBox(height: 20,),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context,int index) {
            return Container(
              margin:const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: btnColor,width: 3)
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Vx.randomColor,
                    child: Image.asset("assets/icons/ic_user.png"),
                  ),
                ),
                title: "Username".text.semiBold.color(txtColor).make(),
                subtitle: "20:47 PM".text.gray400.make(),
              ),
              
            );
          },
        ),
      ],
    ),
  );
}