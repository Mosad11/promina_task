import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_task/core/helper/extenstion/extensions.dart';
import 'package:promina_task/core/networking/cache_helper.dart';
import 'package:promina_task/cubits/app_cubit/app_cubit.dart';
import 'package:promina_task/cubits/app_cubit/app_states.dart';
import 'package:promina_task/cubits/auth_cubit/auth_cubit.dart';
import 'package:promina_task/view/login_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    const List<Color> scaffoldColors = [
      Color.fromARGB(255, 253, 250, 249),
      Color.fromARGB(255, 222, 206, 255),
      Color.fromARGB(255, 253, 250, 249),
    ];
    const BoxDecoration gradientDecoration = BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            stops: [0.01, 1.5, 1],
            colors: scaffoldColors));
    AppCubit cubit = AppCubit.get(context);
    AuthCubit authcubit = AuthCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is UploadHomeSuccessState) {
          cubit.gellaryData();
        }
      },
      builder: (context, state) {
        return DecoratedBox(
            decoration: gradientDecoration,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: RefreshIndicator(
                  color: Colors.blueAccent,
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      cubit.gellaryData();
                    });
                  },
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SafeArea(
                          child:
                              Stack(alignment: Alignment.topCenter, children: [
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
                            Image.asset("assets/images/2.png")
                          ],
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                          child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Welcome",
                                            style: TextStyle(
                                                fontSize: 22.sp,
                                                color: const Color(0xff4A4A4A)),
                                          ),
                                          Text(
                                            authcubit.loginModel!.user!.name!,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0xff4A4A4A)),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Image.asset("assets/images/camera.png")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 40.h,
                                          width: 140.w,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r)),
                                                  backgroundColor:
                                                      Colors.white),
                                              onPressed: () {
                                                CacheHelper.removeData(
                                                        key: 'token')
                                                    .then((value) {
                                                  if (value) {
                                                    navigateAndFinish(context,
                                                        const LoginScreen());
                                                  }
                                                });
                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      "assets/images/logout.png"),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    'log out',
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        SizedBox(
                                          height: 40.h,
                                          width: 140.w,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r)),
                                                  backgroundColor:
                                                      Colors.white),
                                              onPressed: () {
                                                uploadMethod(context);
                                              },
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      "assets/images/upload.png"),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    'upload',
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  ConditionalBuilder(
                                    condition: cubit.gellaryModel != null,
                                    builder: (context) => GridView.count(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                      clipBehavior: Clip.hardEdge,
                                      childAspectRatio: 1 / 1,
                                      children: List.generate(
                                          cubit.gellaryModel!.data!.images!
                                              .length,
                                          (index) => Card(
                                              clipBehavior: Clip.hardEdge,
                                              color: Colors.white,
                                              elevation: 5,
                                              child: Image.network(
                                                cubit.gellaryModel!.data!
                                                    .images![index],
                                                fit: BoxFit.fill,
                                                height: double.infinity,
                                                width: double.infinity,
                                              ))),
                                    ),
                                    fallback: (context) => const Center(
                                        child: CircularProgressIndicator()),
                                  )
                                ],
                              )),
                        )
                      ]))),
                )));
      },
    );
  }

  Future<dynamic> uploadMethod(BuildContext context) {
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Colors.white.withOpacity(0.4),
          ),
          child: AlertDialog(
              content: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SizedBox(
                width: 200.w,
                height: 160.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 50.h,
                      width: 155.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            AppCubit.get(context).uploadFile();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/images/gallery.png",
                                width: 35.w,
                                height: 35.h,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                'gallary',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 50.h,
                      width: 155.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              AppCubit.get(context).cameraFile();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/images/camera.png",
                                width: 35.w,
                                height: 35.h,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                'Camera',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
