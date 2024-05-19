import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_task/cubits/app_cubit/app_cubit.dart';
import 'package:promina_task/cubits/auth_cubit/auth_cubit.dart';

class AppRoot extends StatelessWidget {
  final Widget? startWidget;
  const AppRoot({Key? key, this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => AppCubit()..gellaryData()),
        BlocProvider(create: (BuildContext context) => AuthCubit()..userLogin),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            ),
            home: startWidget,
          );
        },
      ),
    );
  }
}
