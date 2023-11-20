import 'package:chatapp_project/consts/colors.dart';
import 'package:chatapp_project/consts/strings.dart';
import 'package:chatapp_project/consts/utils.dart';
import 'package:chatapp_project/controller/auth_controller.dart';
//import 'package:chatapp_project/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: letsconnect.text.black.fontFamily(bold).make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              //username field
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 3) {
                            return "Please enter your username";
                          }
                          return null;
                        },
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Vx.gray400,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Vx.gray400,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone_android_rounded,
                            color: Vx.gray600,
                          ),
                          alignLabelWithHint: true,
                          labelText: "Username",
                          hintText: "eg. Alex",
                          labelStyle: const TextStyle(
                            color: Vx.gray600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //phone field
                      TextFormField(
                         validator: (value) {
                          if (value!.isEmpty || value.length < 10) {
                            return "Please enter your phone";
                          }
                          return null;
                        },
                        controller: controller.phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Vx.gray400,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Vx.gray400,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone_android_rounded,
                            color: Vx.gray600,
                          ),
                          alignLabelWithHint: true,
                          labelText: "Phone number",
                          prefixText: "+1",
                          labelStyle: const TextStyle(
                            color: Vx.gray600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              otp.text.semiBold.size(16).make(),

              //otp field
              Obx(
                () => Visibility(
                  visible: controller.isOtpsent.value,
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          6,
                          (index) => SizedBox(
                                width: 56,
                                child: TextField(
                                  controller: controller.otpController[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: bold,
                                    color: btnColor,
                                  ),
                                  onChanged: (value) {
                                    if (value.length == 1 && index <= 5) {
                                      FocusScope.of(context).nextFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "*",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: bgColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                        color: bgColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                ),
              ),

              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: context.screenWidth - 80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        //primary: bgColor,
                        backgroundColor: bgColor,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(16)),
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.isOtpsent.value == false) {
                          controller.isOtpsent.value = true;
                          await controller.sendOtp();
                        } else {
                          await controller.verifyOtp(context);
                        }
                      }

                      // controller.isOtpsent.value==true;
                      // await controller.sendOtp();

                      // print(controller.phoneController.text);
                    },
                    child: continuneText.text.semiBold.size(16).make(),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
