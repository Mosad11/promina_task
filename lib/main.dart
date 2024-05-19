import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina_task/core/networking/cache_helper.dart';
import 'package:promina_task/core/networking/dio_helper.dart';
import 'package:promina_task/src/bloc_observable.dart';
import 'package:promina_task/src/root/app_root.dart';
import 'package:promina_task/view/home_screen/home_screen.dart';
import 'package:promina_task/view/login_screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = const SimpleBlocObserver();
  Widget widget;
  String? token = CacheHelper.getData(key: 'token');
  if (token != null) {
    widget = const HomeScreen();
  } else {
    widget = const LoginScreen();
  }

  runApp(AppRoot(
    startWidget: widget,
  ));
}
