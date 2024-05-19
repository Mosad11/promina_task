import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:promina_task/core/components/components.dart';
import 'package:promina_task/core/helper/extenstion/extensions.dart';
import 'package:promina_task/core/networking/cache_helper.dart';
import 'package:promina_task/cubits/auth_cubit/auth_cubit.dart';
import 'package:promina_task/cubits/auth_cubit/auth_states.dart';
import 'package:promina_task/view/home_screen/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<Color> scaffoldColors = [
      Color.fromARGB(255, 252, 229, 224),
      Color.fromARGB(255, 232, 152, 218),
      Color.fromARGB(255, 221, 205, 255),
      Color.fromARGB(255, 255, 218, 218),
      Color.fromARGB(255, 253, 250, 249),
    ];
    const BoxDecoration gradientDecoration = BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            stops: [0.01, 0.3, 0.5, 0.6, 0.75],
            colors: scaffoldColors));
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();

    AuthCubit cubit = AuthCubit.get(context);

    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginStateSuccessState) {
          // ignore: unnecessary_null_comparison
          if (state.loginmodel.user!.name! != null) {
            CacheHelper.saveData(key: 'token', value: state.loginmodel.token!)
                .then((value) {
              showToast(
                text: ("login successfully"),
                state: ToastStates.SUCCESS,
                toastLength: Toast.LENGTH_LONG,
              );
              Future.delayed(const Duration(seconds: 5), () {
                navigateAndFinish(context, const HomeScreen());
              });
            });
          } else {
            showToast(
              text: "check your email/password",
              state: ToastStates.ERROR,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        }
      },
      builder: (context, state) {
        return DecoratedBox(
          decoration: gradientDecoration,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                    key: formKey,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Image.asset("assets/images/0.png"),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset("assets/images/1.png"),
                                SizedBox(
                                  width: 30.w,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 100.h,
                            ),
                            Image.asset("assets/images/2.png"),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text(
                                "    My\nGellary",
                                style: TextStyle(
                                    fontSize: 36.sp,
                                    height: 1,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff4A4A4A)),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              ClipRRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                  child: SizedBox(
                                    width: 300.w,
                                    height: 300.h,
                                    child: Card(
                                      elevation: 0.9,
                                      semanticContainer: false,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.r)),
                                      shadowColor:
                                          Colors.white.withOpacity(0.1),
                                      color: Colors.white.withOpacity(0.5),
                                      child: Padding(
                                        padding: const EdgeInsets.all(25),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "LOG IN",
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xff4A4A4A)),
                                            ),
                                            TextFormField(
                                              controller: emailController,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              autofocus: false,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                hintText: 'User Name',
                                                hintStyle: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    borderSide:
                                                        BorderSide.none),
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        20.0, 5, 10.0, 5),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'email must be not empty';
                                                }
                                                return null;
                                              },
                                            ),
                                            TextFormField(
                                              controller: passController,
                                              obscureText: true,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              autofocus: false,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                hintText: 'Password',
                                                hintStyle: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                                fillColor: Colors.white,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    borderSide:
                                                        BorderSide.none),
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        20.0, 5, 10.0, 5),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'password must be not empty';
                                                }
                                                return null;
                                              },
                                            ),
                                            ConditionalBuilder(
                                              condition: state
                                                  is! LoginStateLoadingState,
                                              builder: (context) =>
                                                  defaultButton(
                                                      function: () {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          cubit.userLogin(
                                                              email:
                                                                  emailController
                                                                      .text,
                                                              password:
                                                                  passController
                                                                      .text);
                                                        }
                                                      },
                                                      text: "SUBMIT",
                                                      width: double.infinity,
                                                      radius: 10.r),
                                              fallback: (context) => const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
